package com.texture_image.extensions

import android.content.Context
import coil.size.PixelSize
import coil.transform.*
import com.texture_image.constants.Quality
import com.texture_image.proto.ImageInfo
import kotlin.math.roundToInt

/**
 * Translate the size into pixel value from Flutter to native side
 */
fun ImageInfo.ImageFetchInfo.pixelSize(context: Context): PixelSize {
    val reduceFactor = scaleFactor(context)
    val width = (geometry.width * reduceFactor).roundToInt()
    val height = (geometry.height * reduceFactor).roundToInt()

    val oddWidth = when (width % 2 == 0) {
        true -> width
        else -> width + 1
    }

    val oddHeight = when (height % 2 == 0) {
        true -> height
        else -> height + 1
    }

    return PixelSize(oddWidth, oddHeight)
}

fun ImageInfo.ImageFetchInfo.parseCoilTransformations(context: Context): List<Transformation> {
    val transforms = mutableListOf<Transformation>()

    if (geometry.isCircleBorderRadius) {
        transforms.add(CircleCropTransformation())
    } else if (!geometry.isEmptyBorderRadius) {
        val scaleFactor = scaleFactor(context)
        with(geometry.borderRadius) {
            transforms.add(
                RoundedCornersTransformation(
                    topLeft = topLeft.toFloat() * scaleFactor,
                    topRight = topRight.toFloat() * scaleFactor,
                    bottomLeft = bottomLeft.toFloat() * scaleFactor,
                    bottomRight = bottomRight.toFloat() * scaleFactor,
                )
            )
        }
    }

    if (blur > 0) {
        // Coil blur value range from 0 to 25, but flutter gives value from 0 to 50
        transforms.add(BlurTransformation(context, blur * 0.5f, blurSampling))
    }

    if (grayScale) {
        transforms.add(GrayscaleTransformation())
    }

    return transforms
}

fun ImageInfo.ImageFetchInfo.scaleFactor(context: Context): Float {
    return with(context.resources.displayMetrics) {
        val qualityFactor = if (quality.autoDownscale) {
            val triggerSize =
                quality.minimumAutoDownscaleTriggerSize.coerceAtLeast(Quality.effectSize)

            when {
                geometry.width <= triggerSize && geometry.height <= triggerSize -> 1.0f
                densityDpi in 240..400 -> Quality.autoDownscaleMediumQuality
                densityDpi > 400 -> Quality.autoDownscaleWorstQuality
                else -> Quality.autoDownscaleFullQuality
            }
        } else {
            1.0f
        }

        qualityFactor * density
    }
}

val ImageInfo.ImageFetchInfo.compressionQuality: Int
    get() {
        return quality.quality.coerceAtLeast(1).coerceAtMost(100)
    }

val ImageInfo.ImageFetchInfo.shouldCompress: Boolean
    get() {
        return compressionQuality in 0..99
    }