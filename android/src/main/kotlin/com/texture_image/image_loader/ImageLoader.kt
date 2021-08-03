package com.texture_image.image_loader

import android.content.Context
import android.graphics.Bitmap
import androidx.annotation.NonNull
import coil.request.Disposable
import coil.util.CoilUtils
import com.texture_image.constants.TaskMap
import com.texture_image.constants.TaskOutlineCache
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo
import com.texture_image.utils.LogUtil
import com.texture_image.utils.ResultUtils
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.view.TextureRegistry
import okhttp3.OkHttpClient

class ImageLoader(
    private val context: Context,
    private val textureRegistry: TextureRegistry
) : LoaderTaskScheduler {
    companion object {
        const val maxCacheSize: Int = 20
    }

    private val taskMap: TaskMap = TaskMap()
    private val outlineCache: TaskOutlineCache = TaskOutlineCache(maxCacheSize)
    private val loaderCore: coil.ImageLoader by lazy(LazyThreadSafetyMode.NONE) {
        val httpClient = OkHttpClient.Builder()
            .cache(CoilUtils.createDefaultCache(context))
            .build()

        coil.ImageLoader.Builder(context)
            .crossfade(true)
            .bitmapConfig(Bitmap.Config.ARGB_8888)
            .okHttpClient(httpClient)
            .build()
    }

    // region Task Scheduler
    override fun schedule(task: ImageLoaderTask): Disposable? {
        val request = task.outline.request ?: return null
        return loaderCore.enqueue(request)
    }

    override fun onTaskStateUpdated(task: ImageLoaderTask) {
        LogUtil.d("State updated: ${task.outline.id}: ${task.outline.state}")

//        if (task.outline.didStop) {
//            removeTaskFromMap(task).also { cacheTaskIfPossible(it) }
//        } else if (task.outline.isInitialized) {
//            saveTaskToMap(task)
//        }

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

        val base64Data = call.arguments as ByteArray
        val imageInfo = try {
            ImageInfo.ImageFetchInfo.parseFrom(base64Data)
        } catch (e: Exception) {
            LogUtil.e("createTextureImage: build ImageRequestInfo failed: $e")
            null
        }

        if (imageInfo == null) {
            result.success(
                ResultUtils.protoParseFailed(
                    "ImageRequestInfo",
                    "createTextureImage"
                )
            )
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

        val base64Data = call.arguments as ByteArray
        val cancelInfo = try {
            ImageInfo.ImageFetchCancelInfo.parseFrom(base64Data)
        } catch (e: Exception) {
            LogUtil.e("disposeTextureImage: build CancelInfo failed: $e")
            null
        }

        if (cancelInfo == null) {
            result.success(
                ResultUtils.protoParseFailed(
                    "ImageFetchCancelInfo",
                    "disposeTextureImage"
                )
            )
            return
        }

        destroyImage(cancelInfo.textureId, cancelInfo.url).also {
            result.success(ResultUtils.success(it))
        }
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
            imageInfo.url,
            imageInfo.placeholder,
            imageInfo.errorPlaceholder,
            imageInfo.geometry,
            cachePolicy,
            entry
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

        task?.dispose()
        return removeTaskFromMap(task)
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

    private fun cacheTaskIfPossible(taskOutline: TaskOutline?): Boolean {
        if (taskOutline == null || !taskOutline.isCompleted) {
            return false
        }

        if (outlineCache.contains(taskOutline)) {
            return true
        }

        if (outlineCache.size > maxCacheSize) {
            val evict = outlineCache.removeFirst()
            evict.release()
        }

        LogUtil.d("cacheTaskIfPossible: ${taskOutline.id}")

        outlineCache.addLast(taskOutline)
        return true
    }

    private fun findReusableTask(imageInfo: ImageInfo.ImageFetchInfo): TaskOutline? {
        val find = { list: Collection<TaskOutline> ->
            try {
                list.first {
                    it.imageUrl == imageInfo.url && it.isCompleted
                }
            } catch (e: Exception) {
                null
            }
        }

        val outlineMap = taskMap.values.map { it.outline }
        return (find(outlineMap) ?: find(outlineCache)).also {
            LogUtil.d("findReusableTask: ${it?.id}")
        }
    }

    private fun saveTaskToMap(task: ImageLoaderTask): TaskOutline {
        LogUtil.d("saveTaskToMap: ${task.outline.id}")

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

        LogUtil.d("removeTaskFromMap: ${task.outline.id}")

        taskMap.remove(task.outline.id)
        return task.outline
    }
    // endregion Helper Methods
}
