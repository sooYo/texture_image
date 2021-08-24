package com.texture_image.image_loader

import android.content.Context
import androidx.annotation.NonNull
import coil.request.Disposable
import coil.util.CoilUtils
import com.texture_image.constants.TaskMap
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
        val request = task.outline.request ?: return null
        return loaderCore.enqueue(request)
    }

    override fun onTaskStateUpdated(task: ImageLoaderTask) {
        if (task.outline.isInitialized) {
            saveTaskToMap(task)
        }
    }
    // endregion Task Scheduler

    // region Channel Handlers
    fun createTextureImage(@NonNull call: MethodCall, @NonNull result: Result) {
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

        loadImage(imageInfo).also { result.success(ResultUtils.success(it)) }
    }

    fun disposeTextureImage(
        @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        if (!checkArgumentType(call, result)) {
            return
        }

        val cancelInfo = try {
            ImageInfo.ImageDisposeInfo.parseFrom(call.arguments as ByteArray)
        } catch (e: Exception) {
            LogUtil.e("disposeTextureImage: build ImageDisposeInfo failed: $e")
            null
        }

        if (cancelInfo == null) {
            ResultUtils.protoParseFailed(
                "ImageDisposeInfo",
                "disposeTextureImage"
            ).also { result.success(it) }
            return
        }

        destroyImage(cancelInfo.textureId, cancelInfo.url).also {
            result.success(ResultUtils.success(it))
        }
    }

    fun updateGlobalConfig(@NonNull call: MethodCall, @NonNull result: Result) {
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
    // endregion Channel Handlers

    // region Core Methods
    private fun loadImage(
        imageInfo: ImageInfo.ImageFetchInfo,
        cachePolicy: CachePolicy = CachePolicy()
    ): TaskOutline {
        val entry = textureRegistry.createSurfaceTexture()
        val task = ImageLoaderTask(
            context,
            imageInfo,
            cachePolicy,
            entry,
        ).scheduleWith(this)

        return task.outline
    }

    private fun destroyImage(textureId: Long, url: String): TaskOutline? {
        val task: ImageLoaderTask? = try {
            if (textureId >= 0) {
                taskMap[textureId]
            } else {
                taskMap.values.first { it.outline.imageUrl == url }
            }
        } catch (e: Exception) {
            null
        }

        return task?.run {
            removeTaskFromMap(this)
            dispose()
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

    private fun saveTaskToMap(task: ImageLoaderTask): TaskOutline {
        val taskId = task.outline.id
        if (taskId >= 0) {
            taskMap[taskId] = task
        }

        return task.outline
    }

    private fun removeTaskFromMap(task: ImageLoaderTask?): TaskOutline? {
        if (task == null) {
            return null
        }

        taskMap.remove(task.outline.id)
        return task.outline
    }
    // endregion Helper Methods
}
