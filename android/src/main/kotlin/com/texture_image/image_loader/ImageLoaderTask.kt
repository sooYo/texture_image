package com.texture_image.image_loader

import android.content.Context
import android.graphics.Paint
import android.graphics.Rect
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.view.Surface
import coil.request.ImageRequest
import coil.target.Target
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
        private val textureEntry: SurfaceTextureEntry
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
                entry = textureEntry,
                imageUrl = imageUrl
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
        if (result !is BitmapDrawable) {
            return
        }

        val rect = Rect(0, 0, geometry.width!!, 1300)
        val surfaceTexture = textureEntry.surfaceTexture()

        surfaceTexture.setDefaultBufferSize(rect.width(), rect.height())
        val surface = Surface(surfaceTexture)
        val canvas = surface.lockCanvas(rect)

        val paint = Paint()
        paint.isAntiAlias = true;
        paint.isFilterBitmap = true;
        paint.isDither = true;

        canvas.drawBitmap(result.bitmap, null, rect, paint)
        surface.unlockCanvasAndPost(canvas)
    }

    override fun onStart(placeholder: Drawable?) {
        super.onStart(placeholder)
    }
    // endRegion Coil Target
}