package com.texture_image.image_loader

import android.content.Context
import android.graphics.drawable.Drawable
import coil.request.ImageRequest
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.constants.TaskState
import com.texture_image.models.CachePolicy
import com.texture_image.models.Geometry
import com.texture_image.models.TaskOutline

class ImageLoaderTask(
        private val context: Context,
        private val imageUrl: String,
        private val geometry: Geometry,
        private val cachePolicy: CachePolicy,
        private val textureEntry: SurfaceTextureEntry,
) : Target {
    private var outline: TaskOutline? = null

    fun build(): TaskOutline? {
        val builder = ImageRequest
                .Builder(context)
                .target(this)
                .data(imageUrl)
                .diskCachePolicy(cachePolicy.coilDiskCache)
                .memoryCachePolicy(cachePolicy.coilMemCache)
                .networkCachePolicy(cachePolicy.coilNetworkCache)

        val size = geometry.size
        if (size != null) {
            builder.size(size)
        }

        outline = TaskOutline(
                request = builder.build(),
                state = TaskState.INITIALIZED,
                cancelToken = null,
                surface = null,
                retryCount = 0,
        )

        return outline
    }

    fun cancel() {
        if (outline?.isLoading != true) {
            return
        }

        if (outline?.cancelToken == null) {
            error("-2: No token to be canceled")
        }

        outline?.cancelToken?.dispose()
    }

    // region Coil Target
    override fun onError(error: Drawable?) {
        super.onError(error)
    }

    override fun onSuccess(result: Drawable) {
        super.onSuccess(result)
    }

    override fun onStart(placeholder: Drawable?) {
        super.onStart(placeholder)
    }
    // endRegion Coil Target
}