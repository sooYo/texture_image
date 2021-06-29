package com.texture_image.image_loader

import android.content.Context
import android.graphics.Bitmap
import androidx.annotation.NonNull
import coil.util.CoilUtils
import com.texture_image.constants.LoaderTaskMap
import com.texture_image.constants.TaskState
import com.texture_image.models.CachePolicy
import com.texture_image.models.Geometry
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.view.TextureRegistry
import okhttp3.OkHttpClient

class ImageLoader(
        private val context: Context,
        private val textureRegistry: TextureRegistry
) {
    private val taskMap: LoaderTaskMap = LoaderTaskMap()

    private val loaderCore: ImageLoader? by lazy(LazyThreadSafetyMode.NONE) {
        val httpClient = OkHttpClient.Builder()
                .cache(CoilUtils.createDefaultCache(context))
                .build()

        ImageLoader.Builder(context)
                .crossfade(true)
                .availableMemoryPercentage(0.25)
                .bitmapConfig(Bitmap.Config.ARGB_8888)
                .okHttpClient(httpClient)
                .build()
    }

    // region Channel Handlers
    fun createTextureImage(@NonNull call: MethodCall, @NonNull result: Result) {


    }

    fun disposeTextureImage(@NonNull call: MethodCall, @NonNull result: Result) {

    }
    // endRegion Channel Handlers

    fun loadImage(url: String, geometry: Geometry, cachePolicy: CachePolicy = CachePolicy()) {
        val entry = textureRegistry.createSurfaceTexture()
        val taskOutline = ImageLoaderTask(context, url, geometry, cachePolicy, entry)
                .build()
                ?: return

        if (taskOutline.request == null) {
            return
        }

        val cancelToken = loaderCore?.enqueue(taskOutline.request!!)
        taskOutline.cancelToken = cancelToken
        taskOutline.state = TaskState.LOADING

        taskMap[entry.id()] = taskOutline
    }

    fun cancel(url: String) {
        val outline = taskMap.values.first { e -> e.request?.data == url }
        outline.cancelToken?.dispose()
    }
}
