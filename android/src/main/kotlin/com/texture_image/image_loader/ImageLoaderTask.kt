package com.texture_image.image_loader

import android.content.Context
import android.graphics.Paint
import android.graphics.Rect
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.view.Surface
import coil.request.Disposable
import coil.request.ImageRequest
import coil.size.PixelSize
import coil.target.Target
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageUtils

interface ImageRequestScheduler {
    fun schedule(request: ImageRequest): Disposable
}

class ImageLoaderTask(
    private val context: Context,
    private val imageUrl: String,
    private val geometry: ImageUtils.Geometry,
    private val cachePolicy: CachePolicy,
    private val textureEntry: SurfaceTextureEntry
) : Target {
    private var outline: TaskOutline? = null

    fun buildWithScheduler(scheduler: ImageRequestScheduler): TaskOutline {
        val builder = ImageRequest
            .Builder(context)
            .target(this)
            .data(imageUrl)
            .size(PixelSize(geometry.width, geometry.height))
            .diskCachePolicy(cachePolicy.coilDiskCache)
            .memoryCachePolicy(cachePolicy.coilMemCache)
            .networkCachePolicy(cachePolicy.coilNetworkCache)

        val request = builder.build()
        val cancelToken = scheduler.schedule(request)

        outline = TaskOutline(
            imageUrl = imageUrl,
            request = request,
            entry = textureEntry,
            cancelToken = cancelToken,
        )

        return outline!!
    }

    fun cancel() {
        if (outline == null) {
            return
        }

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

        val rect = Rect(0, 0, geometry.width, 1300)
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