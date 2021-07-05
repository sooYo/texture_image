package com.texture_image.models

import android.widget.ImageView
import coil.size.PixelSize
import coil.size.Size
import com.texture_image.proto.ImageInfo

class Geometry(
        val width: Int?,
        val height: Int?,
        val borderRadius: BorderRadius,
        val scaleType: ImageView.ScaleType,
) {
    companion object {
        fun fromImageInfo(info: ImageInfo.ImageRequestInfo): Geometry {
            val borderRadius = BorderRadius.fromImageBorderRadius(info.borderRadius)
            return Geometry(info.width, info.height, borderRadius, ImageView.ScaleType.FIT_CENTER)
        }
    }

    val size: Size?
        get() {
            return when {
                width != null && height != null -> PixelSize(width, height)
                else -> null
            }
        }
}

class BorderRadius(
        val topLeft: Double,
        val topRight: Double,
        val bottomLeft: Double,
        val bottomRight: Double
) {
    companion object {
        fun fromImageBorderRadius(borderRadius: ImageInfo.ImageBorderRadius): BorderRadius {
            return BorderRadius(
                    topLeft = borderRadius.topLeft,
                    topRight = borderRadius.topRight,
                    bottomLeft = borderRadius.bottomLeft,
                    bottomRight = borderRadius.bottomRight
            )
        }
    }
}
