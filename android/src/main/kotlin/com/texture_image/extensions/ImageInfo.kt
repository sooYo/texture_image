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

        PixelSize(
            (geometry.width * density * reduceFactor).roundToInt(),
            (geometry.height * density * reduceFactor).roundToInt()
        )
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