package com.texture_image.extensions

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Rect
import android.graphics.RectF
import android.opengl.Matrix
import android.util.Log
import com.texture_image.utils.LogUtil
import kotlin.math.roundToInt

// region Scaled Bitmap
@Suppress("unused")
fun Bitmap.boxFitFill(width: Int, height: Int): Bitmap {
    return try {
        Bitmap.createScaledBitmap(this, width, height, true)
    } catch (e: Exception) {
        Log.e("BitmapUtils", "boxFitFill: $e")
        this
    }
}

@Suppress("unused")
fun Bitmap.boxFitContains(width: Int, height: Int): Bitmap {
    val matrix = matrixKeepAspectRatio(width, height, true)
    return try {
        return Bitmap.createBitmap(
            this,
            0,
            0,
            this.width,
            this.height,
            matrix,
            true
        )
    } catch (e: Exception) {
        Log.e("BitmapUtils", "boxFitContains: $e")
        this
    }
}

@Suppress("unused")
fun Bitmap.boxFitCover(width: Int, height: Int): Bitmap {
    val matrix = matrixKeepAspectRatio(width, height, false)
    return try {
        return Bitmap.createBitmap(
            this,
            0,
            0,
            this.width,
            this.height,
            matrix,
            true
        )
    } catch (e: Exception) {
        Log.e("BitmapUtils", "boxFitCover: $e")
        this
    }
}

@Suppress("unused")
fun Bitmap.boxFitFitWidth(width: Int): Bitmap {
    return try {
        val ratio = this.width.toFloat() / this.height.toFloat()
        val height = (width / ratio).roundToInt()

        Bitmap.createScaledBitmap(
            this,
            width,
            height,
            true
        )
    } catch (e: Exception) {
        Log.e("BitmapUtils", "boxFitFitWidth: $e")
        this
    }
}

@Suppress("unused")
fun Bitmap.boxFitFitHeight(height: Int): Bitmap {
    return try {
        val ratio = this.height.toFloat() / this.width.toFloat()
        val width = (height / ratio).roundToInt()

        Bitmap.createScaledBitmap(
            this,
            width,
            height,
            true
        )
    } catch (e: Exception) {
        Log.e("BitmapUtils", "boxFitFitHeight: $e")
        this
    }
}
// endregion Scaled Bitmap

// region Scaled Rect
@Suppress("unused")
fun Bitmap.rectBoxFitFill(width: Int, height: Int): Rect {
    return Rect(0, 0, width, height)
}

@Suppress("unused")
fun Bitmap.rectBoxFitContains(width: Int, height: Int): Rect {
    return rectKeepAspectRatio(width, height, true)
}

@Suppress("unused")
fun Bitmap.rectBoxFitCover(width: Int, height: Int): Rect {
    return rectKeepAspectRatio(width, height, false)
}

@Suppress("unused")
fun Bitmap.rectBoxFitFitWidth(width: Int, height: Int): Rect {
    val ratio = this.width.toFloat() / this.height.toFloat()
    val scaledHeight = (width / ratio).roundToInt()
    val yPos = (height - scaledHeight) * 0.5

    return Rect(0, 0, width, scaledHeight).apply {
        offsetTo(0, yPos.roundToInt())
    }
}

@Suppress("unused")
fun Bitmap.rectBoxFitFitHeight(width: Int, height: Int): Rect {
    val ratio = this.height.toFloat() / this.width.toFloat()
    val scaledWidth = (height / ratio).roundToInt()
    val xPos = (width - scaledWidth) * 0.5

    return Rect(0, 0, scaledWidth, height).apply {
        offsetTo(xPos.roundToInt(), 0)
    }
}
// endregion Scaled Rect

// region Flutter Assets
@Suppress("unused")
fun bitmapFromAsset(
    context: Context,
    assetPath: String,
    flutterAsset: Boolean = true
): Bitmap? {
    return try {
        val stream = when (flutterAsset) {
            true -> "flutter_assets/$assetPath"
            else -> assetPath
        }.run {
            context.assets.open(this)
        }

        BitmapFactory.decodeStream(stream)
    } catch (e: Exception) {
        LogUtil.e("bitmapFromAsset: $e")
        null
    }
}

// endregion Flutter Assets

// region OpenGL Matrix
@Suppress("unused")
fun Bitmap.matrixBufferBoxFitFill(
    @Suppress("unused_parameter") width: Int,
    @Suppress("unused_parameter") height: Int
): FloatArray {
    // An identity matrix represents a scaled-fill image
    return FloatArray(16).apply {
        Matrix.setIdentityM(this, 0)
    }
}

@Suppress("unused")
fun Bitmap.matrixBufferBoxFitContains(
    srcWidth: Int,
    srcHeight: Int
): FloatArray {
    val rBitmap = width / height.toFloat()
    val rCanvas = srcWidth / srcHeight.toFloat()
    val fillHorizontal = rBitmap > rCanvas

    return FloatArray(16).apply {
        val left = if (fillHorizontal) -1f else -rCanvas / rBitmap
        val top = if (fillHorizontal) 1 / rCanvas * rBitmap else 1f

        Matrix.setIdentityM(this, 0)
        Matrix.orthoM(this, 0, left, -1 * left, -1 * top, top, 1f, -1f)
    }
}

@Suppress("unused")
fun Bitmap.matrixBufferBoxFitCover(
    srcWidth: Int,
    srcHeight: Int
): FloatArray {
    val rBitmap = width / height.toFloat()
    val rCanvas = srcWidth / srcHeight.toFloat()
    val fillHorizontal = rBitmap > rCanvas

    return FloatArray(16).apply {
        val left = if (!fillHorizontal) -1f else -rCanvas / rBitmap
        val top = if (!fillHorizontal) 1 / rCanvas * rBitmap else 1f

        Matrix.setIdentityM(this, 0)
        Matrix.orthoM(this, 0, left, -1 * left, -1 * top, top, 1f, -1f)
    }
}

@Suppress("unused")
fun Bitmap.matrixBufferBoxFitFitWidth(
    srcWidth: Int,
    srcHeight: Int
): FloatArray {
    val bitmapRatio = width / height.toFloat()
    val canvasRatio = srcWidth / srcHeight.toFloat()

    return FloatArray(16).apply {
        val top = 1 / canvasRatio * bitmapRatio
        Matrix.setIdentityM(this, 0)
        Matrix.orthoM(this, 0, -1f, 1f, -1 * top, top, 1f, -1f)
    }
}

@Suppress("unused")
fun Bitmap.matrixBufferBoxFitFitHeight(
    srcWidth: Int,
    srcHeight: Int
): FloatArray {
    val bitmapRatio = width / height.toFloat()
    val canvasRatio = srcWidth / srcHeight.toFloat()

    return FloatArray(16).apply {
        val left = -canvasRatio / bitmapRatio
        Matrix.setIdentityM(this, 0)
        Matrix.orthoM(this, 0, left, -1 * left, -1f, 1f, 1f, -1f)
    }
}

// endregion OpenGL Matrix

private fun Bitmap.rectKeepAspectRatio(
    width: Int,
    height: Int,
    fitInside: Boolean
): Rect {
    val rect = Rect(0, 0, this.width, this.height)
    val rectF = RectF().apply { set(rect) }

    matrixKeepAspectRatio(width, height, fitInside).apply { mapRect(rectF) }

    return rect.apply {
        rectF.roundOut(this)
        offsetTo(
            ((width - rect.width()) * 0.5).roundToInt(),
            ((height - rect.height()) * 0.5).roundToInt()
        )
    }
}

private fun Bitmap.matrixKeepAspectRatio(
    width: Int,
    height: Int,
    fitInside: Boolean
): android.graphics.Matrix {
    val scaledWidth = width.toFloat() / this.width
    val scaledHeight = height.toFloat() / this.height
    val scaleRatio = when (fitInside) {
        true -> scaledHeight.coerceAtMost(scaledWidth)
        else -> scaledHeight.coerceAtLeast(scaledWidth)
    }

    return android.graphics.Matrix().apply { postScale(scaleRatio, scaleRatio) }
}


