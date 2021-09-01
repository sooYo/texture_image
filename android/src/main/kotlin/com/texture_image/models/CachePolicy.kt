package com.texture_image.models

import coil.request.CachePolicy

class CachePolicy(
    memoryCache: Boolean = true,
    diskCache: Boolean = true,
    networkCache: Boolean = true,
) {
    val coilDiskCache: CachePolicy = toCoilCachePolicy(diskCache)
    val coilMemCache: CachePolicy = toCoilCachePolicy(memoryCache)
    val coilNetworkCache: CachePolicy = toCoilCachePolicy(networkCache)

    private fun toCoilCachePolicy(enable: Boolean): CachePolicy {
        return when {
            enable -> CachePolicy.ENABLED
            else -> CachePolicy.DISABLED
        }
    }
}
