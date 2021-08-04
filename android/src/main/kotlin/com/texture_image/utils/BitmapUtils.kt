package com.texture_image.utils

import android.content.Context
import android.graphics.*
import android.util.Log
import kotlin.math.roundToInt

fun Bitmap.boxFitFill(width: Int, height: Int): Bitmap {
    return try {
        Bitmap.createScaledBitmap(this, width, height, true)
    } catch (e: Exception) {
        Log.e("BitmapUtils", "boxFitFill: $e")
        this
    }
}

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

fun Bitmap.rectBoxFitFill(width: Int, height: Int): Rect {
    return Rect(0, 0, width, height)
}

fun Bitmap.rectBoxFitContains(width: Int, height: Int): Rect {
    return rectKeepAspectRatio(width, height, true)
}

fun Bitmap.rectBoxFitCover(width: Int, height: Int): Rect {
    return rectKeepAspectRatio(width, height, false)
}

fun Bitmap.rectBoxFitWidth(width: Int, height: Int): Rect {
    val ratio = this.width.toFloat() / this.height.toFloat()
    val scaledHeight = (width / ratio).roundToInt()
    val yPos = (height - scaledHeight) * 0.5

    return Rect(0, 0, width, scaledHeight).apply {
        offsetTo(0, yPos.roundToInt())
    }
}

fun Bitmap.rectBoxFitHeight(width: Int, height: Int): Rect {
    val ratio = this.height.toFloat() / this.width.toFloat()
    val scaledWidth = (height / ratio).roundToInt()
    val xPos = (width - scaledWidth) * 0.5

    return Rect(0, 0, scaledWidth, height).apply {
        offsetTo(xPos.roundToInt(), 0)
    }
}

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
): Matrix {
    val scaledWidth = width.toFloat() / this.width
    val scaledHeight = height.toFloat() / this.height
    val scaleRatio = when (fitInside) {
        true -> scaledHeight.coerceAtMost(scaledWidth)
        else -> scaledHeight.coerceAtLeast(scaledWidth)
    }

    return Matrix().apply { postScale(scaleRatio, scaleRatio) }
}


