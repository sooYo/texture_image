package com.texture_image.models

import android.widget.ImageView
import coil.size.PixelSize
import coil.size.Size

class Geometry(
        val width: Int?,
        val height: Int?,
        val borderRadius: Double,
        val scaleType: ImageView.ScaleType,
) {
    val size: Size?
        get() {
            return when {
                width != null && height != null -> PixelSize(width, height)
                else -> null
            }
        }
}
