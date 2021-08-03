package com.texture_image.image_loader

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.view.Surface
import coil.request.ImageRequest
import coil.size.PixelSize
import coil.target.Target
import coil.transform.Transformation
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.models.TaskOutlineBuilder
import com.texture_image.proto.ImageUtils
import com.texture_image.proto.ImageUtils.BoxFit.*
import com.texture_image.utils.*
import kotlin.properties.Delegates

class ImageLoaderTask(
    private val context: Context,
    private val imageUrl: String,
    private val placeholder: String?,
    private val errorPlaceholder: String?,
    private val geometry: ImageUtils.Geometry,
    private val cachePolicy: CachePolicy,
    private val textureEntry: SurfaceTextureEntry
) : Target {
    private var scheduler: LoaderTaskScheduler? = null
    private var mOutline: TaskOutline
            by Delegates.observable(TaskOutline.undefined) { _, oldValue, newValue ->
                if (scheduler == null || oldValue.state == newValue.state) {
                    return@observable
                }

                scheduler?.onTaskStateUpdated(this)
            }

    val outline: TaskOutline get() = mOutline

    fun scheduleWith(scheduler: LoaderTaskScheduler): ImageLoaderTask {
        this.scheduler = scheduler

        // Collect transformations as much as possible
        val transform = ArrayList<Transformation>()
        val shapeTransform = geometry.parseCoilShapeTransform()
        if (shapeTransform != null) {
            transform.add(shapeTransform)
        }

        val assetManager = context.assets
        val placeholder = assetManager.open("flutter_assets/$placeholder")
        val bitmap = BitmapFactory.decodeStream(placeholder)
        val d: Drawable = BitmapDrawable(context.resources, bitmap)

        val request = ImageRequest
            .Builder(context)
            .target(this)
            .data(imageUrl)
            .size(PixelSize(geometry.width, geometry.height))
            .diskCachePolicy(cachePolicy.coilDiskCache)
            .memoryCachePolicy(cachePolicy.coilMemCache)
            .networkCachePolicy(cachePolicy.coilNetworkCache)
            .transformations(transform)
            .placeholder(d)
            .build()

        mOutline = TaskOutlineBuilder()
            .setRequest(request)
            .setImageUrl(imageUrl)
            .setEntry(textureEntry)
            .build()

        val cancelToken = scheduler.schedule(this)

        if (!outline.isCompleted) {
            mOutline = TaskOutlineBuilder()
                .clone(mOutline)
                .setCancelToken(cancelToken)
                .build()
        }

        return this
    }

    fun dispose(): TaskOutline {
        mOutline.release()
        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setTexture(null)
            .setEntry(null)
            .setSurface(null)
            .setCancelToken(null)
            .setState(ImageUtils.TaskState.disposed)
            .build()

        return mOutline
    }

    // region Coil Target
    override fun onError(error: Drawable?) {
        LogUtil.d("OnError: ${outline.imageUrl}")

        mOutline.release()
        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setTexture(null)
            .setEntry(null)
            .setSurface(null)
            .setCancelToken(null)
            .setState(ImageUtils.TaskState.failed)
            .build()
    }

    @SuppressLint("Recycle")
    override fun onSuccess(result: Drawable) {
        LogUtil.d("onSuccess: ${outline.imageUrl}")

        if (result !is BitmapDrawable) {
            return
        }

        val width = geometry.width
        val height = geometry.height
        val bitmap = result.bitmap.copy(Bitmap.Config.ARGB_8888, true)

        val texture = textureEntry.surfaceTexture()
        val surface = texture.apply {
            setDefaultBufferSize(width, height)
        }.let { Surface(it) }

        Rect(0, 0, 0, 0).let { surface.lockCanvas(it) }.apply {
            drawFilter = PaintFlagsDrawFilter(
                0,
                Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG
            )

            drawBitmap(
                bitmap,
                null,
                canvasTargetRect(bitmap, geometry),
                null
            )

            surface.unlockCanvasAndPost(this)
            bitmap.recycle()
        }

        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setSurface(surface)
            .setTexture(texture)
            .setState(ImageUtils.TaskState.completed)
            .build()
    }

    override fun onStart(placeholder: Drawable?) {
        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.loading)
            .build()
    }
    // endregion Coil Target

    @Suppress("unused")
    private fun scaleBitmap(
        bitmap: Bitmap,
        geometry: ImageUtils.Geometry
    ): Bitmap {
        val width = geometry.width
        val height = geometry.height

        return when (geometry.fit) {
            fitHeight -> bitmap.boxFitFitHeight(height)
            fitWidth -> bitmap.boxFitFitWidth(width)
            cover -> bitmap.boxFitCover(width, height)
            contain -> bitmap.boxFitContains(width, height)
            fill -> bitmap.boxFitFill(width, height)
            else -> bitmap
        }
    }

    private fun canvasTargetRect(
        bitmap: Bitmap,
        geometry: ImageUtils.Geometry
    ): Rect {
        val width = geometry.width
        val height = geometry.height

        return when (geometry.fit) {
            fitHeight -> bitmap.rectBoxFitHeight(width, height)
            fitWidth -> bitmap.rectBoxFitWidth(width, height)
            cover -> bitmap.rectBoxFitCover(width, height)
            contain -> bitmap.rectBoxFitContains(width, height)
            fill -> bitmap.rectBoxFitFill(width, height)
            else -> Rect(0, 0, bitmap.width, bitmap.height)
        }
    }
}