package com.texture_image.image_loader

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Rect
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.view.Surface
import coil.request.Disposable
import coil.request.ImageRequest
import coil.size.PixelSize
import coil.target.Target
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.constants.TaskMap
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.models.TaskOutlineBuilder
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
    private lateinit var mOutline: TaskOutline
    val outline: TaskOutline get() = mOutline

    fun scheduleWith(scheduler: ImageRequestScheduler): ImageLoaderTask {
        val request = ImageRequest
            .Builder(context)
            .target(this)
            .data(imageUrl)
            .size(PixelSize(geometry.width, geometry.height))
            .diskCachePolicy(cachePolicy.coilDiskCache)
            .memoryCachePolicy(cachePolicy.coilMemCache)
            .networkCachePolicy(cachePolicy.coilNetworkCache)
            .build()

        mOutline = TaskOutlineBuilder()
            .setRequest(request)
            .setImageUrl(imageUrl)
            .setEntry(textureEntry)
            .build()

        val cancelToken = scheduler.schedule(request)

        if (!outline.isCompleted) {
            mOutline = TaskOutlineBuilder()
                .clone(mOutline)
                .setCancelToken(cancelToken)
                .build()
        }

        return this
    }

    fun cancel(): TaskOutline {
        if (mOutline.didStop) {
            return mOutline
        }

        mOutline.cancelToken?.dispose()
        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.canceled)
            .build()

        return mOutline
    }

    fun joinTaskMap(taskMap: TaskMap): TaskOutline {
        val taskId = mOutline.id
        if (taskId >= 0) {
            taskMap[taskId] = this
        }

        return mOutline
    }

    // region Coil Target
    override fun onError(error: Drawable?) {
        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.failed)
            .build()
    }

    @SuppressLint("Recycle")
    override fun onSuccess(result: Drawable) {
        if (result !is BitmapDrawable) {
            return
        }

        val rect = Rect(0, 0, geometry.width, geometry.height)
        val surfaceTexture = textureEntry.surfaceTexture()

        surfaceTexture.setDefaultBufferSize(rect.width(), rect.height())
        val surface = Surface(surfaceTexture)
        val canvas = surface.lockCanvas(rect)

        canvas.drawBitmap(result.bitmap, null, rect, null)
        surface.unlockCanvasAndPost(canvas)

        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setSurface(surface)
            .setState(ImageUtils.TaskState.completed)
            .build()
    }

    override fun onStart(placeholder: Drawable?) {
        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.loading)
            .build()
    }
    // endRegion Coil Target
}