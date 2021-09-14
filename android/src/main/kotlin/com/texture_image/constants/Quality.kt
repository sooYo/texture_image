package com.texture_image.constants

object Quality {
    // Multipliers of size calculation
    const val autoDownscaleFullQuality = 0.7
    const val autoDownscaleMediumQuality = 0.5
    const val autoDownscaleWorstQuality = 0.4

    // Smaller size than this value will forbidden auto-downscale
    const val effectSize = 80
}