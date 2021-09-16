package com.texture_image.extensions

import com.texture_image.proto.ImageUtils
import kotlin.math.abs

fun Double.equalsDelta(other: Double, delta: Double = 0.0001): Boolean {
    return abs(this - other) < delta
}

val ImageUtils.Geometry.isEmptyBorderRadius: Boolean
    get() {
        return borderRadius.topLeft.equalsDelta(0.0) &&
                borderRadius.topRight.equalsDelta(0.0) &&
                borderRadius.bottomLeft.equalsDelta(0.0) &&
                borderRadius.bottomRight.equalsDelta(0.0)
    }

val ImageUtils.Geometry.isCircleBorderRadius: Boolean
    get() {
        if (width != height || isEmptyBorderRadius) {
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

