package com.texture_image.render

import android.graphics.*
import com.texture_image.extensions.*
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo.ImageFetchInfo
import com.texture_image.proto.ImageUtils.BoxFit.*
import com.texture_image.utils.ConfigUtil
import com.texture_image.utils.LogUtil
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream

class CanvasRender(
    private val imageInfo: ImageFetchInfo
) : Renderer {

    @DelicateCoroutinesApi
    override fun render(
        bitmap: Bitmap,
        srcWidth: Int,
        srcHeight: Int,
        taskContext: TaskOutline,
    ) {
        compressBeforeDrawing(
            bitmap,
            srcWidth,
            srcHeight,
            taskContext,
        )
    }

    override fun release() {}

    override val isReleased: Boolean = false

    @DelicateCoroutinesApi
    private fun compressBeforeDrawing(
        bitmap: Bitmap,
        srcWidth: Int,
        srcHeight: Int,
        outline: TaskOutline,
    ) {
        if (outline.texture == null || outline.surface == null) {
            return
        }

        if (imageInfo.shouldCompress) {
            GlobalScope.launch(Dispatchers.Default) {
                val output = ByteArrayOutputStream()

                bitmap.compress(
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

                val compressBitmap = BitmapFactory.decodeStream(
                    inputStream,
                    null,
                    opt
                )

                GlobalScope.launch(Dispatchers.Main) {
                    drawBitmap(
                        compressBitmap ?: bitmap,
                        srcWidth,
                        srcHeight,
                        outline,
                    )
                }
            }
        } else {
            drawBitmap(bitmap, srcWidth, srcHeight, outline)
        }
    }

    private fun drawBitmap(
        bitmap: Bitmap,
        srcWidth: Int,
        srcHeight: Int,
        outline: TaskOutline,
    ) {
        if (outline.texture == null || outline.surface == null) {
            return
        }

        try {
            outline.surface.lockCanvas(null).apply {
                drawFilter = PaintFlagsDrawFilter(
                    0,
                    Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG
                )

                // "Clean" old picture
                drawColor(Color.TRANSPARENT, PorterDuff.Mode.CLEAR)
                drawBitmap(
                    bitmap,
                    null,
                    canvasTargetRect(bitmap, srcWidth, srcHeight),
                    null
                )

                outline.surface.unlockCanvasAndPost(this)
            }
        } catch (e: Exception) {
            LogUtil.e("Draw bitmap: $e")
        }
    }

    // region Bitmap Fitting
    private fun canvasTargetRect(
        bitmap: Bitmap,
        width: Int,
        height: Int
    ): Rect {
        with(bitmap) {
            return when (imageInfo.geometry.fit) {
                fitHeight -> rectBoxFitFitHeight(width, height)
                fitWidth -> rectBoxFitFitWidth(width, height)
                cover -> rectBoxFitCover(width, height)
                contain -> rectBoxFitContains(width, height)
                else -> rectBoxFitFill(width, height)
            }
        }
    }

    @Suppress("unused")
    private fun scaleBitmap(
        bitmap: Bitmap,
        width: Int,
        height: Int
    ): Bitmap {
        with(bitmap) {
            return when (imageInfo.geometry.fit) {
                fitHeight -> boxFitFitHeight(height)
                fitWidth -> boxFitFitWidth(width)
                cover -> boxFitCover(width, height)
                contain -> boxFitContains(width, height)
                fill -> boxFitFill(width, height)
                else -> this
            }
        }
    }
    // endregion Bitmap Fitting
}