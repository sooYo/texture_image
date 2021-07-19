package com.texture_image.image_loader

import android.content.Context
import android.graphics.Bitmap
import android.util.Log
import androidx.annotation.NonNull
import coil.request.Disposable
import coil.request.ImageRequest
import coil.util.CoilUtils
import com.texture_image.constants.LoaderTaskMap
import com.texture_image.models.CachePolicy
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
    }

    private val taskMap: LoaderTaskMap = LoaderTaskMap()
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

        val textureId = loadImage(imageInfo.url, imageInfo.geometry)
        result.success(textureId)
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
            Log.e(
                TAG,
                "disposeTextureImage: build ImageRequestCancelInfo failed: $e"
            )
            null
        }

        if (cancelInfo == null) {
            result.success(
                ResultUtils.protoParseFailed(
                    "ImageRequestCancelInfo",
                    "disposeTextureImage"
                )
            )
            return
        }

        destroyImage(cancelInfo.url)
    }
    // endregion Channel Handlers

    // region Core
    private fun loadImage(
        url: String,
        geometry: ImageUtils.Geometry,
        cachePolicy: CachePolicy = CachePolicy()
    ): Long {
        val entry = textureRegistry.createSurfaceTexture()
        val taskOutline = ImageLoaderTask(
            context,
            url,
            geometry,
            cachePolicy,
            entry
        ).buildWithScheduler(this)

        taskMap[entry.id()] = taskOutline
        return entry.id()
    }

    private fun destroyImage(url: String) {
        val outline = taskMap.values.first { e -> e.request.data == url }
        outline.cancelToken.dispose()
    }
    // endregion core

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
    // endregion Helper Methods
}
