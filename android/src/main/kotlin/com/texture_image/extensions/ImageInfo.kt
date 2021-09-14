package com.texture_image.extensions

import android.content.Context
import coil.size.PixelSize
import com.texture_image.constants.Quality
import com.texture_image.proto.ImageInfo
import kotlin.math.roundToInt

/**
 * Translate the size into pixel value from Flutter to native side
 */
fun ImageInfo.ImageFetchInfo.pixelSize(context: Context): PixelSize {
    return with(context.resources.displayMetrics) {
        val reduceFactor = if (quality.autoDownscale) {
            val triggerSize =
                quality.minimumAutoDownscaleTriggerSize.coerceAtLeast(Quality.effectSize)

            when {
                geometry.width <= triggerSize && geometry.height <= triggerSize -> 1.0
                densityDpi in 240..400 -> Quality.autoDownscaleMediumQuality
                densityDpi > 400 -> Quality.autoDownscaleWorstQuality
                else -> Quality.autoDownscaleFullQuality
            }
        } else {
            1.0
        }

        val width = (geometry.width * density * reduceFactor).roundToInt()
        val height = (geometry.height * density * reduceFactor).roundToInt()

        val oddWidth = when (width % 2 == 0) {
            true -> width
            else -> width + 1
        }

        val oddHeight = when (height % 2 == 0) {
            true -> height
            else -> height + 1
        }

        PixelSize(oddWidth, oddHeight)
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