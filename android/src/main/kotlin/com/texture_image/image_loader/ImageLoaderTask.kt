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
import com.texture_image.extensions.*
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.models.TaskOutlineBuilder
import com.texture_image.proto.ImageInfo
import com.texture_image.proto.ImageUtils
import com.texture_image.proto.ImageUtils.BoxFit.*
import com.texture_image.utils.*
import kotlinx.coroutines.*
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import kotlin.properties.Delegates

class ImageLoaderTask(
    private val context: Context,
    private val imageInfo: ImageInfo.ImageFetchInfo,
    private val cachePolicy: CachePolicy,
    private val textureEntry: SurfaceTextureEntry,
) : Target {
    private var scheduler: LoaderTaskScheduler? = null
    private val imageSize: PixelSize by lazy {
        imageInfo.pixelSize(context)
    }
    private var mOutline: TaskOutline
            by Delegates.observable(TaskOutline.undefined) { _, oldValue, newValue ->
                if (scheduler == null || oldValue.state == newValue.state) {
                    return@observable
                }

                scheduler?.onTaskStateUpdated(this)
            }

    val outline: TaskOutline get() = mOutline

    @SuppressLint("Recycle")
    fun scheduleWith(scheduler: LoaderTaskScheduler): ImageLoaderTask {
        this.scheduler = scheduler

        // Collect transformations as much as possible
        val transform = ArrayList<Transformation>()
        val shapeTransform = imageInfo.geometry.parseCoilShapeTransform()
        if (shapeTransform != null) {
            transform.add(shapeTransform)
        }

        val builder = ImageRequest
            .Builder(context)
            .target(this)
            .data(imageInfo.url)
            .size(imageSize)
            .transformations(transform)
            .allowRgb565(!imageInfo.geometry.supportAlpha)
            .diskCachePolicy(cachePolicy.coilDiskCache)
            .memoryCachePolicy(cachePolicy.coilMemCache)
            .networkCachePolicy(cachePolicy.coilNetworkCache)

        PlaceholderUtil.run {
            assignLoadingPlaceholder(context, imageInfo.placeholder, builder)
            assignErrorPlaceholder(context, imageInfo.errorPlaceholder, builder)
        }

        val texture = textureEntry.surfaceTexture().also {
            it.setDefaultBufferSize(
                imageSize.width,
                imageSize.height
            )
        }

        val surface = Surface(texture)
        mOutline = TaskOutlineBuilder()
            .setRequest(builder.build())
            .setImageUrl(imageInfo.url)
            .setEntry(textureEntry)
            .setTexture(texture)
            .setSurface(surface)
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
    override fun onStart(placeholder: Drawable?) {
        val loadingIcon = if (placeholder is BitmapDrawable) {
            placeholder.bitmap
        } else {
            PlaceholderUtil.placeholder
        }

        if (loadingIcon != null) {
            drawBitmap(loadingIcon)
        }

        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.loading)
            .build()
    }

    override fun onError(error: Drawable?) {
        val errorIcon = if (error is BitmapDrawable) {
            error.bitmap
        } else {
            PlaceholderUtil.errorPlaceholder
        }

        if (errorIcon != null) {
            drawBitmap(errorIcon)
        }

        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.failed)
            .build()
    }

    @DelicateCoroutinesApi
    override fun onSuccess(result: Drawable) {
        if (result is BitmapDrawable) {
            if (imageInfo.shouldCompress) {
                GlobalScope.launch(Dispatchers.Default) {
                    val output = ByteArrayOutputStream()

                    result.bitmap.compress(
                        Bitmap.CompressFormat.JPEG,
                        imageInfo.compressionQuality,
                        output
                    )

                    val byteArray = output.toByteArray()
                    val inputStream = ByteArrayInputStream(byteArray)
                    val opt = BitmapFactory.Options().apply {
                        inSampleSize = 1
                        inPreferredConfig = Bitmap.Config.RGB_565
                    }

                    val bitmap = BitmapFactory.decodeStream(
                        inputStream,
                        null,
                        opt
                    )

                    GlobalScope.launch(Dispatchers.Main) {
                        drawBitmap(bitmap ?: result.bitmap)
                    }
                }
            } else {
                drawBitmap(result.bitmap)
            }

            mOutline = TaskOutlineBuilder()
                .clone(mOutline)
                .setState(ImageUtils.TaskState.completed)
                .build()
        }
    }
    // endregion Coil Target

    @Suppress("unused")
    private fun scaleBitmap(bitmap: Bitmap): Bitmap {
        val width = imageSize.width
        val height = imageSize.height

        return when (imageInfo.geometry.fit) {
            fitHeight -> bitmap.boxFitFitHeight(height)
            fitWidth -> bitmap.boxFitFitWidth(width)
            cover -> bitmap.boxFitCover(width, height)
            contain -> bitmap.boxFitContains(width, height)
            fill -> bitmap.boxFitFill(width, height)
            else -> bitmap
        }
    }

    private fun canvasTargetRect(bitmap: Bitmap): Rect {
        val width = imageSize.width
        val height = imageSize.height

        return when (imageInfo.geometry.fit) {
            fitHeight -> bitmap.rectBoxFitHeight(width, height)
            fitWidth -> bitmap.rectBoxFitWidth(width, height)
            cover -> bitmap.rectBoxFitCover(width, height)
            contain -> bitmap.rectBoxFitContains(width, height)
            fill -> bitmap.rectBoxFitFill(width, height)
            else -> Rect(0, 0, bitmap.width, bitmap.height)
        }
    }

    private fun drawBitmap(bitmapToDraw: Bitmap) {
        if (mOutline.texture == null || mOutline.surface == null) {
            return
        }

        try {
            mOutline.surface!!.lockCanvas(null).apply {
                drawFilter = PaintFlagsDrawFilter(
                    0,
                    Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG
                )

                drawBitmap(
                    bitmapToDraw,
                    null,
                    canvasTargetRect(bitmapToDraw),
                    null
                )

                mOutline.surface!!.unlockCanvasAndPost(this)
            }
        } catch (e: Exception) {
            LogUtil.e("Draw bitmap: $e")
        }
    }
}