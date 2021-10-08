package com.texture_image.image_loader

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Size
import android.view.Surface
import coil.request.Disposable
import coil.request.ImageRequest
import coil.size.PixelSize
import coil.target.Target
import com.texture_image.extensions.*
import com.texture_image.models.CachePolicy
import com.texture_image.models.TaskOutline
import com.texture_image.models.TaskOutlineBuilder
import com.texture_image.proto.ImageInfo
import com.texture_image.proto.ImageUtils
import com.texture_image.proto.ImageUtils.BoxFit.*
import com.texture_image.render.CanvasRender
import com.texture_image.render.OpenGLRender
import com.texture_image.render.Renderer
import com.texture_image.utils.*
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.TextureRegistry
import kotlinx.coroutines.*
import kotlin.properties.Delegates

class ImageLoaderTask(
    private val context: Context,
    private val cachePolicy: CachePolicy,
    private val registry: TextureRegistry,
) : Target {
    private var scheduler: LoaderTaskScheduler? = null
    private var mImageRequest: ImageRequest? = null
    private var cancelToken: Disposable? = null
    private var imageRender: Renderer? = null
    private var callback: MethodChannel.Result? = null

    private lateinit var imageInfo: ImageInfo.ImageFetchInfo

    private val imagePixelSize: PixelSize
        get() = imageInfo.pixelSize(context)

    private var mOutline: TaskOutline
            by Delegates.observable(TaskOutline.undefined) { _, oldValue, newValue ->
                if (scheduler == null ||
                    oldValue.state == newValue.state ||
                    newValue.state == ImageUtils.TaskState.undefined
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
    fun scheduleWith(
        scheduler: LoaderTaskScheduler,
        imageInfo: ImageInfo.ImageFetchInfo
    ): ImageLoaderTask {
        this.scheduler = scheduler
        this.imageInfo = imageInfo
        this.mImageRequest = coilRequest()

        val outlineBuilder = TaskOutlineBuilder()

        if (mOutline.entry == null) {
            val textureEntry = registry.createSurfaceTexture()
            val texture = textureEntry.surfaceTexture().also {
                it.setDefaultBufferSize(
                    imagePixelSize.width,
                    imagePixelSize.height
                )
            }

            outlineBuilder
                .setEntry(textureEntry)
                .setTexture(texture)
                .setSurface(Surface(texture))
        } else {
            outlineBuilder.clone(mOutline)
        }

        mOutline = outlineBuilder
            .setImageUrl(imageInfo.url)
            .setState(ImageUtils.TaskState.initialized)
            .build()

        cancelToken = scheduler.schedule(this)
        return this
    }

    fun dispose(prepareReuse: Boolean = false): TaskOutline {
        assert(callback == null) { "Channel result should be consumed before disposed" }

        cancelToken?.dispose()
        mOutline.release(prepareReuse)

        if (!prepareReuse) {
            imageRender?.release()
            imageRender = null
        }

        scheduler = null
        cancelToken = null
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
                setTexture(null)
                setEntry(null)
                setSurface(null)
            }

            mOutline = build()
        }

        return mOutline
    }

    // region Channel Result
    fun catchChannelCallback(callback: MethodChannel.Result?) {
        if (this.callback != null) {
            throw IllegalStateException("Consume callback before Catching another one!")
        }

        this.callback = callback
    }

    fun consumeChannelCallback(result: ByteArray) {
        this.callback?.success(result)
        this.callback = null
    }

    // endregion Channel Result

    // region Coil Target
    override fun onStart(placeholder: Drawable?) {
        val loadingIcon = when (placeholder is BitmapDrawable) {
            true -> placeholder.bitmap
            else -> ConfigUtil.placeholder
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
            else -> ConfigUtil.errorPlaceholder
        }

        if (errorIcon != null) {
            drawBitmap(errorIcon)
        }

        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.failed)
            .build()
    }

    override fun onSuccess(result: Drawable) {
        if (result is BitmapDrawable) {
            drawBitmap(result.bitmap)
        }

        mOutline = TaskOutlineBuilder()
            .clone(mOutline)
            .setState(ImageUtils.TaskState.completed)
            .build()
    }
    // endregion Coil Target

    private fun coilRequest(): ImageRequest {
        // Collect transformations as much as possible
        val transforms = imageInfo.parseCoilTransformations(context)
        val builder = ImageRequest
            .Builder(context)
            .target(this)
            .data(imageInfo.url)
            .size(imagePixelSize)
            .transformations(transforms)
            .allowRgb565(!imageInfo.geometry.supportAlpha)
            .diskCachePolicy(cachePolicy.coilDiskCache)
            .memoryCachePolicy(cachePolicy.coilMemCache)
            .networkCachePolicy(cachePolicy.coilNetworkCache)

        ConfigUtil.run {
            assignLoadingPlaceholder(context, imageInfo.placeholder, builder)
            assignErrorPlaceholder(context, imageInfo.errorPlaceholder, builder)
        }

        return builder.build()
    }

    private fun drawBitmap(bitmapToDraw: Bitmap) {
        createRenderIfNeeded()

        assert(imageRender != null) { "Image render hasn't be initialized!" }
        assert(!imageRender!!.isReleased) { "Image Render has been released!" }

        if (imageRender == null || imageRender!!.isReleased) {
            return
        }

        imageRender?.render(
            bitmapToDraw,
            imagePixelSize.width,
            imagePixelSize.height,
            mOutline,
        )
    }

    /**
     * Prepare the render if needed
     *
     * I'm considering if we should let the user change render type
     * while application is running, but calling [Renderer.release]
     * on existed render seems reasonable here
     */
    private fun createRenderIfNeeded() {
        if (mOutline.entry == null || mOutline.texture == null) {
            return
        }

        imageRender = when (ConfigUtil.global.useOpenGLRendering) {
            true -> when (imageRender is OpenGLRender) {
                true -> imageRender
                else -> {
                    imageRender?.release()
                    OpenGLRender(mOutline, imageInfo.geometry)
                }
            }

            else -> when (imageRender is CanvasRender) {
                true -> imageRender
                else -> {
                    imageRender?.release()
                    CanvasRender(imageInfo)
                }
            }
        }
    }
}