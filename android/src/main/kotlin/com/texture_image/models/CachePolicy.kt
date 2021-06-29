package com.texture_image.models

import coil.request.CachePolicy
import coil.request.ImageRequest

/**
 * A simple class to describe cache strategy for **Coil**
 *
 * Each parameter relative to a [CachePolicy] of [ImageRequest],
 * while `true` will assign a [CachePolicy.ENABLED], `false` will
 * assign [CachePolicy.DISABLED]
 *
 * @param memoryCache refers to [ImageRequest.memoryCachePolicy]
 * @param diskCache refers to [ImageRequest.diskCachePolicy]
 * @param networkCache refers to [ImageRequest.networkCachePolicy]
 */
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
