package com.texture_image.image_loader

import android.content.Context
import android.graphics.Bitmap
import android.util.Log
import androidx.annotation.NonNull
import coil.request.Disposable
import coil.request.ImageRequest
import coil.util.CoilUtils
import com.texture_image.constants.TaskMap
import com.texture_image.constants.TaskOutlineCache
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo
import com.texture_image.proto.ImageUtils
import com.texture_image.utils.ResultUtils
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.view.TextureRegistry
import okhttp3.OkHttpClient

class ImageLoader(
    private val context: Context,
    private val textureRegistry: TextureRegistry
) : ImageRequestScheduler {
    companion object {
        val TAG = ImageLoader::class.simpleName
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
            .availableMemoryPercentage(0.25)
            .bitmapConfig(Bitmap.Config.ARGB_8888)
            .okHttpClient(httpClient)
            .build()
    }

    override fun schedule(request: ImageRequest): Disposable {
        return loaderCore.enqueue(request)
    }

    // region Channel Handlers
    fun createTextureImage(@NonNull call: MethodCall, @NonNull result: Result) {
        if (!checkArgumentType(call, result)) {
            return
        }

        val base64Data = call.arguments as ByteArray
        val imageInfo = try {
            ImageInfo.ImageFetchInfo.parseFrom(base64Data)
        } catch (e: Exception) {
            Log.e(TAG, "createTextureImage: build ImageRequestInfo failed: $e")
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

        val taskOutline = findReusableTask(imageInfo) ?: loadImage(
            imageInfo.url,
            imageInfo.geometry
        )

        result.success(ResultUtils.success(taskOutline))
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
            Log.e(TAG, "disposeTextureImage: build CancelInfo failed: $e")
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

        val outline = destroyImage(cancelInfo.textureId, cancelInfo.url)
        result.success(ResultUtils.success(outline))
    }
    // endregion Channel Handlers

    // region Core Methods
    private fun loadImage(
        url: String,
        geometry: ImageUtils.Geometry,
        cachePolicy: CachePolicy = CachePolicy()
    ): TaskOutline {
        val entry = textureRegistry.createSurfaceTexture()
        val task = ImageLoaderTask(
            context,
            url,
            geometry,
            cachePolicy,
            entry
        ).scheduleWith(this)

        return task.joinTaskMap(taskMap)
    }

    private fun destroyImage(textureId: Long, url: String): TaskOutline? {
        val task: ImageLoaderTask? = try {
            if (textureId >= 0) {
                taskMap[textureId]
            } else {
                taskMap.values.first { e -> e.outline.imageUrl == url }
            }
        } catch (e: Exception) {
            null
        }

        val outline = task?.cancel()
        cacheTaskIfPossible(outline)
        return outline
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
        if (taskOutline == null) {
            return false
        }

        taskMap.remove(taskOutline.id)

        if (!taskOutline.isCompleted) {
            return false
        }

        if (outlineCache.contains(taskOutline)) {
            return true
        }

        if (outlineCache.size > maxCacheSize) {
            val evict = outlineCache.removeFirst()
            evict.release()
        }

        outlineCache.addLast(taskOutline)
        return true
    }

    private fun findReusableTask(imageInfo: ImageInfo.ImageFetchInfo): TaskOutline? {
        val find = { list: Collection<TaskOutline> ->
            try {
                list.first { e ->
                    e.imageUrl == imageInfo.url && (e.isReusable || e.isCompleted)
                }
            } catch (e: Exception) {
                null
            }
        }

        val outlineMap = taskMap.values.map { e -> e.outline }
        val result = find(outlineMap) ?: find(outlineCache)
        return result
    }
    // endregion Helper Methods
}
