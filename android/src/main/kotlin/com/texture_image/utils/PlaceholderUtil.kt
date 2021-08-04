package com.texture_image.utils

import android.content.Context
import android.graphics.Bitmap
import com.texture_image.proto.ImageInfo

object PlaceholderUtil {
    private var mGlobalPlaceholder: Bitmap? = null
    private var mGlobalErrorPlaceholder: Bitmap? = null

    val placeholder: Bitmap? get() = mGlobalPlaceholder
    val errorPlaceholder: Bitmap? get() = mGlobalErrorPlaceholder

    fun loadPlaceholders(
        context: Context,
        imageConfigInfo: ImageInfo.ImageConfigInfo
    ) {
        if (!imageConfigInfo.placeholder.isNullOrBlank()) {
            mGlobalPlaceholder = bitmapFromAsset(
                context,
                imageConfigInfo.placeholder
            )
        }

        if (!imageConfigInfo.errorPlaceholder.isNullOrBlank()) {
            mGlobalErrorPlaceholder = bitmapFromAsset(
                context,
                imageConfigInfo.errorPlaceholder
            )
        }
    }
}