package com.texture_image.models

import coil.request.CachePolicy
import coil.request.ImageRequest

class CachePolicy(
    private val memoryCache: Boolean = true,
    private val diskCache: Boolean = true,
    private val networkCache: Boolean = true,
) {
    val coilDiskCache: CachePolicy
        get() {
            return toCoilCachePolicy(diskCache)
        }

    val coilMemCache: CachePolicy
        get() {
            return toCoilCachePolicy(memoryCache)
        }

    val coilNetworkCache: CachePolicy
        get() {
            return toCoilCachePolicy(networkCache)
        }

    private fun toCoilCachePolicy(enable: Boolean): CachePolicy {
        return when {
            enable -> CachePolicy.ENABLED
            else -> CachePolicy.DISABLED
        }
    }
}
