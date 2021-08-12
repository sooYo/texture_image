package com.texture_image.utils

import android.content.Context
import coil.size.PixelSize
import coil.transform.BlurTransformation
import coil.transform.CircleCropTransformation
import coil.transform.RoundedCornersTransformation
import coil.transform.Transformation
import com.texture_image.proto.ImageUtils
import kotlin.math.abs
import kotlin.math.roundToInt

fun Double.equalsDelta(other: Double, delta: Double = 0.0001): Boolean {
    return abs(this - other) < delta
}

fun ImageUtils.Geometry.isEmptyBorderRadius(): Boolean {
    return borderRadius.topLeft.equalsDelta(0.0) &&
            borderRadius.topRight.equalsDelta(0.0) &&
            borderRadius.bottomLeft.equalsDelta(0.0) &&
            borderRadius.bottomRight.equalsDelta(0.0)
}

fun ImageUtils.Geometry.isCircleBorderRadius(): Boolean {
    if (width != height || isEmptyBorderRadius()) {
        return false
    }

    val radius: Double = width * 0.5
    if (radius.equalsDelta(0.0)) {
        return false
    }

    return borderRadius.topLeft.equalsDelta(radius) &&
            borderRadius.topRight.equalsDelta(radius) &&
            borderRadius.bottomLeft.equalsDelta(radius) &&
            borderRadius.bottomRight.equalsDelta(radius)
}

/**
 * To parse [Transformation] from the borderRadius
 *
 * This method only parse the shape-relative [Transformation]s,
 * it will ignore the effects like [BlurTransformation]
 */
fun ImageUtils.Geometry.parseCoilShapeTransform(): Transformation? {
    if (isEmptyBorderRadius()) {
        return null
    }

    if (isCircleBorderRadius()) {
        return CircleCropTransformation()
    }

    return RoundedCornersTransformation(
        topLeft = borderRadius.topLeft.toFloat(),
        topRight = borderRadius.topRight.toFloat(),
        bottomLeft = borderRadius.bottomLeft.toFloat(),
        bottomRight = borderRadius.bottomRight.toFloat()
    )
}

/**
 * Translate the size into pixel value from Flutter to native side
 */
fun ImageUtils.Geometry.pixelSize(context: Context): PixelSize {
    val density = context.resources.displayMetrics.density
    return PixelSize(
        (width * density * 0.5).roundToInt(),
        (height * density * 0.5).roundToInt()
    )
}