package com.texture_image.image_loader

import android.content.Context
import android.util.Log
import android.util.Size
import androidx.annotation.NonNull
import coil.request.Disposable
import coil.util.CoilUtils
import com.texture_image.constants.TaskMap
import com.texture_image.constants.TaskReuseMap
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo
import com.texture_image.utils.LogUtil
import com.texture_image.utils.PlaceholderUtil
import com.texture_image.utils.ResultUtils
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.view.TextureRegistry
import okhttp3.OkHttpClient

class ImageLoader(
    private val context: Context,
    private val textureRegistry: TextureRegistry
) : LoaderTaskScheduler {
    private var globalConfig: ImageInfo.ImageConfigInfo? = null

    private val taskMap: TaskMap = TaskMap()
    private val taskReuseMap: TaskReuseMap = TaskReuseMap()
    private val loaderCore: coil.ImageLoader by lazy(LazyThreadSafetyMode.NONE) {
        val httpClient = OkHttpClient.Builder()
            .cache(CoilUtils.createDefaultCache(context))
            .build()

        val memOp = globalConfig?.androidAvailableMemoryPercentage ?: 0.1

        coil.ImageLoader.Builder(context)
            .okHttpClient(httpClient)
            .availableMemoryPercentage(memOp)
            .allowHardware(false)
            .build()
    }

    // region Task Scheduler
    override fun schedule(task: ImageLoaderTask): Disposable? {
        val request = task.imageRequest ?: return null
        return loaderCore.enqueue(request)
    }

    override fun onTaskStateUpdated(task: ImageLoaderTask) {
        if (task.outline.isInitialized) {
            saveToTaskMap(task)
        }
    }
    // endregion Task Scheduler

    // region Channel Handlers
    fun createTextureImage(
        @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        if (!checkArgumentType(call, result)) {
            return
        }

        val imageInfo = try {
            ImageInfo.ImageFetchInfo.parseFrom(call.arguments as ByteArray)
        } catch (e: Exception) {
            LogUtil.e("createTextureImage: build ImageRequestInfo failed: $e")
            null
        }

        if (imageInfo == null) {
            ResultUtils.protoParseFailed(
                "ImageRequestInfo",
                "createTextureImage"
            ).also { result.success(it) }
            return
        }

        loadImage(imageInfo).also {
            result.success(ResultUtils.success(it))
        }
    }

    fun disposeTextureImage(
        @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        if (!checkArgumentType(call, result)) {
            return
        }

        val disposeInfo = try {
            ImageInfo.ImageDisposeInfo.parseFrom(call.arguments as ByteArray)
        } catch (e: Exception) {
            LogUtil.e("disposeTextureImage: build ImageDisposeInfo failed: $e")
            null
        }

        if (disposeInfo == null) {
            ResultUtils.protoParseFailed(
                "ImageDisposeInfo",
                "disposeTextureImage"
            ).also { result.success(it) }
            return
        }

        destroyImage(disposeInfo).also {
            result.success(ResultUtils.success(it))
        }
    }

    fun updateGlobalConfig(
        @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        if (!checkArgumentType(call, result)) {
            return
        }

        val base64Data = call.arguments as ByteArray
        val configInfo = try {
            ImageInfo.ImageConfigInfo.parseFrom(base64Data)
        } catch (e: Exception) {
            LogUtil.e("updateGlobalConfig: build ImageConfigInfo failed: $e")
            null
        }

        if (configInfo == null) {
            result.success(
                ResultUtils.protoParseFailed(
                    "ImageConfigInfo",
                    "updateGlobalConfig"
                )
            )
            return
        }

        PlaceholderUtil.loadPlaceholders(context, configInfo)

        globalConfig = configInfo
        result.success(ResultUtils.ok)
    }

    fun releaseAllFreeTasks(
        @Suppress("unused_parameter") @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        taskReuseMap.values.forEach {
            it.forEach { task -> task.dispose() }
            it.clear()
        }

        taskReuseMap.clear()
        result.success(ResultUtils.ok)
    }
    // endregion Channel Handlers

    // region Core Methods
    private fun loadImage(
        imageInfo: ImageInfo.ImageFetchInfo,
        cachePolicy: CachePolicy = CachePolicy()
    ): TaskOutline {

        val task = pickTaskFromReuseMap(imageInfo) ?: ImageLoaderTask(
            context,
            imageInfo,
            cachePolicy,
            textureRegistry,
        )

        return task.scheduleWith(this).outline
    }

    private fun destroyImage(disposeInfo: ImageInfo.ImageDisposeInfo): TaskOutline? {
        val task: ImageLoaderTask? = try {
            with(disposeInfo) {
                when {
                    textureId >= 0 -> taskMap.get(textureId)
                    // In case dispose before create function return
                    else -> slowSearchTaskMapByDisposeInfo(disposeInfo)
                }
            }
        } catch (e: Exception) {
            null
        }

        Log.d("TAG", "Destroy search: ${task?.outline?.id}")

        return task?.run {
            when (disposeInfo.canBeReused) {
                true -> moveToReuseMap(this)
                else -> removeFromTaskMap(this)
            }

            dispose(disposeInfo.canBeReused)
        }
    }

    // endregion Core Methods

    // region Helper Methods
    private fun checkArgumentType(
        methodCall: MethodCall,
        result: Result
    ): Boolean {
        if (methodCall.arguments !is ByteArray) {
            result.success(
                ResultUtils.argTypeError(
                    methodCall.method,
                    "arguments",
                    "ByteArray"
                )
            )
            return false
        }

        return true
    }

    private fun saveToTaskMap(task: ImageLoaderTask): TaskOutline {
        with(task) {
            Log.d("TAG", "saveToTaskMap: ${task.outline.id}")
            assert(outline.id >= 0)
            taskMap.put(outline.id, this)
            return outline
        }
    }

    private fun removeFromTaskMap(task: ImageLoaderTask?): TaskOutline? {
        with(task) {
            if (this !is ImageLoaderTask) {
                return null
            }

            taskMap.remove(outline.id)
            return outline
        }
    }

    private fun slowSearchTaskMapByDisposeInfo(disposeInfo: ImageInfo.ImageDisposeInfo): ImageLoaderTask? {
        for (index in 0 until taskMap.size()) {
            val task = taskMap.valueAt(index)
            if (task.outline.imageUrl == disposeInfo.url) {
                return task
            }
        }

        return null
    }

    private fun saveToReuseMap(task: ImageLoaderTask) {
        var cacheList = taskReuseMap[task.imageSizeKey]
        if (cacheList == null) {
            cacheList = mutableListOf()
            taskReuseMap[task.imageSizeKey] = cacheList
        }

        Log.d("TAG", "saveToReuseMap: ${task.outline.id}")
        cacheList.add(task)
    }

    private fun moveToReuseMap(task: ImageLoaderTask?): TaskOutline? {
        if (task == null) {
            return null
        }

        return task.run {
            saveToReuseMap(this)
            removeFromTaskMap(this)
            outline
        }
    }

    private fun pickTaskFromReuseMap(fetchInfo: ImageInfo.ImageFetchInfo): ImageLoaderTask? {
        return with(fetchInfo) {
            val sizeKey = Size(geometry.width, geometry.height)
            val cacheList = taskReuseMap[sizeKey]
            val result = when (cacheList?.isEmpty()) {
                false -> cacheList.removeFirst()
                else -> null
            }

            Log.d("TAG", "pick task: ${result?.outline?.id}")
            result
        }
    }
    // endregion Helper Methods
}
