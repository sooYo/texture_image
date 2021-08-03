package com.texture_image.image_loader

import android.content.Context
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Log
import android.util.LongSparseArray
import android.view.Surface
import coil.ImageLoader
import coil.request.ImageRequest
import coil.target.Target
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.utils.rectBoxFitCover
import io.flutter.view.TextureRegistry
import java.util.*

class TestHelper(private val loader: ImageLoader) : Target {
    private val textureLongSparseArray = LongSparseArray<SurfaceTexture?>()
    private val surfaceLongSparseArray = LongSparseArray<Surface?>()
    private val surfaceEntityArray = LongSparseArray<SurfaceTextureEntry?>()

    private val mHttp = "http"
    private val mDrawable = "drawable"

    fun loadImg(
        context: Context,
        surfaceTextureEntry: TextureRegistry,
        img: String,
        width: Double?,
        height: Double?,
    ): Long {
        return if (img.startsWith(mHttp)) {
            drawImgTexture(
                context,
                surfaceTextureEntry,
                0,
                img,
                width,
                height,
            )
        } else {
            val resId = context.resources.getIdentifier(
                img,
                mDrawable,
                context.packageName
            )
            drawImgTexture(
                context,
                surfaceTextureEntry,
                resId,
                null,
                width,
                height,
            )
        }

    }

    private fun drawImgTexture(
        context: Context,
        surfaceTextureEntry: TextureRegistry,
        imgResource: Int,
        imgUrl: String?,
        width: Double?,
        height: Double?,
    ): Long {
        val entry = surfaceTextureEntry.createSurfaceTexture()
        val surfaceTexture = entry.surfaceTexture()
        val surface = Surface(surfaceTexture)

        surfaceLongSparseArray.put(entry.id(), surface)
        surfaceEntityArray.put(entry.id(), entry)
        textureLongSparseArray.put(entry.id(), surfaceTexture)

        if (imgResource > 0) {
            decodeImg(
                context,
                null,
                surfaceTexture,
                surface,
                width,
                height,
                entry.id()

            )
        } else {
            decodeImg(
                context,
                imgUrl,
                surfaceTexture,
                surface,
                width,
                height,
                entry.id()
            )
        }
        Log.d("TAG", "Save for texture id: ${entry.id()}")

        return entry.id()
    }

    fun cleanTexture(textureId: Long) {
        Log.d("TAG", "Remove for texture id: $textureId")

        try {
            textureLongSparseArray.run {
                this[textureId]?.release()
                remove(textureId)
            }
            surfaceLongSparseArray.run {
                this[textureId]?.release()
                remove(textureId)
            }
            surfaceEntityArray.run {
                this[textureId]?.release()
                remove(textureId)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun decodeImg(
        context: Context,
        imgUrl: String?,
        surfaceTexture: SurfaceTexture,
        surface: Surface,
        width: Double?,
        height: Double?,
        drawType: Long
    ) { //瞬间峰值 250 /mb 不会释放 交给Glide控制 （以demo峰值为例）

        val task = EtHelperUnit {
            if (textureLongSparseArray.get(drawType) == null) {
                return@EtHelperUnit
            }

            val multiple = 1
            try {
                val bitmap = it.copy(Bitmap.Config.ARGB_8888, true)

                surfaceTexture.setDefaultBufferSize(
                    (width!! * multiple).toInt(),
                    (height!! * multiple).toInt()
                )


                Rect(0, 0, 0, 0).let { e -> surface.lockCanvas(e) }.apply {
                    drawFilter = PaintFlagsDrawFilter(
                        0,
                        Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG
                    )

                    val targetRect = bitmap.rectBoxFitCover(
                        width.toInt(),
                        height.toInt()
                    )

                    drawBitmap(
                        bitmap,
                        null,
                        targetRect,
                        null
                    )

                    surface.unlockCanvasAndPost(this)
                }

                bitmap.recycle()
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }

        task.loadImage(context, imgUrl!!, loader, width!!, height!!)
    }
}

private class EtHelperUnit(
    private val callback: (bimap: Bitmap) -> Unit,
) : Target {

    fun loadImage(
        context: Context,
        url: String,
        loader: ImageLoader?,
        width: Double,
        height: Double
    ) {
        val request = ImageRequest
            .Builder(context)
            .target(this)
            .size(width.toInt(), height.toInt())
            .data(url)
            .build()

        loader?.enqueue(request)
    }

    override fun onSuccess(result: Drawable) {
        val resource = (result as BitmapDrawable).bitmap
        callback(resource)
    }
}







