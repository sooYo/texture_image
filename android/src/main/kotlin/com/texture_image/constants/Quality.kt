package com.texture_image.constants

object Quality {
    // Multipliers of size calculation
    const val autoDownscaleFullQuality = 0.8f
    const val autoDownscaleMediumQuality = 0.6f
    const val autoDownscaleWorstQuality = 0.5f

    // Auto-downscale has no effect on sizes smaller than value below
    const val effectSize = 80
}