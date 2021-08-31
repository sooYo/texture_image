package com.texture_image.utils

import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import coil.request.ImageRequest
import com.texture_image.extensions.bitmapFromAsset
import com.texture_image.proto.ImageInfo

object PlaceholderUtil {
    private var mGlobalPlaceholder: Bitmap? = null
    private var mGlobalErrorPlaceholder: Bitmap? = null

    val placeholder: Bitmap? get() = mGlobalPlaceholder
    val errorPlaceholder: Bitmap? get() = mGlobalErrorPlaceholder

    private val placeholderPaths = mutableListOf<String>()

    fun loadPlaceholders(
        context: Context,
        imageConfigInfo: ImageInfo.ImageConfigInfo
    ) {
        if (!imageConfigInfo.placeholder.isNullOrBlank()) {
            mGlobalPlaceholder = bitmapFromAsset(
                context,
                imageConfigInfo.placeholder
            )

            placeholderPaths.add(imageConfigInfo.placeholder)
        }

        if (!imageConfigInfo.errorPlaceholder.isNullOrBlank()) {
            mGlobalErrorPlaceholder = bitmapFromAsset(
                context,
                imageConfigInfo.errorPlaceholder
            )

            placeholderPaths.add(imageConfigInfo.errorPlaceholder)
        }
    }

    fun assignLoadingPlaceholder(
        context: Context,
        path: String?,
        builder: ImageRequest.Builder
    ) = assignPlaceholder(context, path, builder, false)

    fun assignErrorPlaceholder(
        context: Context,
        path: String?,
        builder: ImageRequest.Builder
    ) = assignPlaceholder(context, path, builder, true)

    private fun assignPlaceholder(
        context: Context,
        placeholder: String?,
        builder: ImageRequest.Builder,
        isErrorPlaceholder: Boolean,
    ) {
        if (placeholder in placeholderPaths) {
            // To guarantee not creating multiple instances
            return
        }

        val bitmap = when (placeholder?.isNotEmpty()) {
            true -> bitmapFromAsset(context, placeholder)
            else -> null
        } ?: return

        BitmapDrawable(context.resources, bitmap).also {
            when (isErrorPlaceholder) {
                true -> builder.error(it)
                else -> builder.placeholder(it)
            }
        }
    }
}