package com.texture_image.constants

object Quality {
    // Multipliers of size calculation
    const val autoDownscaleFullQuality = 0.8
    const val autoDownscaleMediumQuality = 0.6
    const val autoDownscaleWorstQuality = 0.5

    // Auto-downscale has no effect on sizes smaller than value below
    const val effectSize = 80
}