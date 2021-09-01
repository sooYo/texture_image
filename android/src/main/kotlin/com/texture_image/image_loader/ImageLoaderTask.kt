package com.texture_image.image_loader

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Log
import android.util.Size
import android.view.Surface
import coil.request.Disposable
import coil.request.ImageRequest
import coil.size.PixelSize
import coil.target.Target
import coil.transform.Transformation
import com.texture_image.extensions.*
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.models.TaskOutlineBuilder
import com.texture_image.proto.ImageInfo
import com.texture_image.proto.ImageUtils
import com.texture_image.proto.ImageUtils.BoxFit.*
import com.texture_image.utils.*
import io.flutter.view.TextureRegistry
import kotlinx.coroutines.*
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import kotlin.properties.Delegates

class ImageLoaderTask(
    private val context: Context,
    private val imageInfo: ImageInfo.ImageFetchInfo,
    private val cachePolicy: CachePolicy,
    private val registry: TextureRegistry,
) : Target {
    private var scheduler: LoaderTaskScheduler? = null
    private var mImageRequest: ImageRequest? = null
    private var mCancelToken: Disposable? = null
    private val mImagePixelSize: PixelSize by lazy {
        imageInfo.pixelSize(context)
    }
    private var mOutline: TaskOutline
            by Delegates.observable(TaskOutline.undefined) { _, oldValue, newValue ->
                if (scheduler == null ||
                    newValue.state == ImageUtils.TaskState.undefined ||
                    oldValue.state == newValue.state
                ) {
                    return@observable
                }

                scheduler?.onTaskStateUpdated(this)
            }

    val outline: TaskOutline get() = mOutline
    val imageRequest: ImageRequest? get() = mImageRequest
    val imageSizeKey: Size
        get() = Size(
            imageInfo.geometry.width,
            imageInfo.geometry.height
        )

    @SuppressLint("Recycle")
    fun scheduleWith(scheduler: LoaderTaskScheduler): ImageLoaderTask {
        this.scheduler = scheduler
        this.mImageRequest = coilRequest()

        val outlineBuilder = TaskOutlineBuilder()

        if (mOutline.entry == null) {
            val textureEntry = registry.createSurfaceTexture()
            val texture = textureEntry.surfaceTexture().also {
                it.setDefaultBufferSize(
                    mImagePixelSize.width,
                    mImagePixelSize.height
                )
            }

            outlineBuilder
                .setEntry(textureEntry)
                .setTexture(texture)
                .setSurface(Surface(texture))
        } else {
            outlineBuilder.clone(mOutline)
        }

        Log.d("TAG", "scheduleWith: ${mOutline.id}")

        mOutline = outlineBuilder
            .setImageUrl(imageInfo.url)
            .setState(ImageUtils.TaskState.initialized)
            .build()

        mCancelToken = scheduler.schedule(this)
        return this
    }

    fun dispose(prepareReuse: Boolean = false): TaskOutline {
        mCancelToken?.dispose()
        mOutline.release(prepareReuse)

        scheduler = null
        mCancelToken = null
        mImageRequest = null

        TaskOutlineBuilder().run {
            clone(mOutline)
            setState(
                when (prepareReuse) {
                    true -> ImageUtils.TaskState.prepreReuse
                    else -> ImageUtils.TaskState.disposed
                }
            )

            if (!prepareReuse) {
                Log.d("TAG", "dispose: ${outline.id} ")
                setTexture(null)
                setEntry(null)
                setSurface(null)
            }

            mOutline = build()
        }

        return mOutline
    }

    // region Coil Target
    override fun onStart(placeholder: Drawable?) {
        val loadingIcon = when (placeholder is BitmapDrawable) {
            true -> placeholder.bitmap
            else -> PlaceholderUtil.placeholder
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
        val errorIcon = when (error is BitmapDrawable) {
            true -> error.bitmap
            else -> PlaceholderUtil.errorPlaceholder
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

    private fun coilRequest(): ImageRequest {
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
            .size(mImagePixelSize)
            .transformations(transform)
            .allowRgb565(!imageInfo.geometry.supportAlpha)
            .diskCachePolicy(cachePolicy.coilDiskCache)
            .memoryCachePolicy(cachePolicy.coilMemCache)
            .networkCachePolicy(cachePolicy.coilNetworkCache)

        PlaceholderUtil.run {
            assignLoadingPlaceholder(context, imageInfo.placeholder, builder)
            assignErrorPlaceholder(context, imageInfo.errorPlaceholder, builder)
        }

        return builder.build()
    }

    @Suppress("unused")
    private fun scaleBitmap(bitmap: Bitmap): Bitmap {
        val width = mImagePixelSize.width
        val height = mImagePixelSize.height

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
        val width = mImagePixelSize.width
        val height = mImagePixelSize.height

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