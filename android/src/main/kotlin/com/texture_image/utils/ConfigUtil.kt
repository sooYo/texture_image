package com.texture_image.utils

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Color
import android.graphics.drawable.BitmapDrawable
import androidx.annotation.ColorInt
import coil.request.ImageRequest
import com.texture_image.extensions.bitmapFromAsset
import com.texture_image.proto.ImageInfo.ImageConfigInfo

object ConfigUtil {
    private var mGlobalConfig: ImageConfigInfo = defaultConfig
    private var mGlobalPlaceholder: Bitmap? = null
    private var mGlobalErrorPlaceholder: Bitmap? = null

    // Background color config
    @ColorInt
    private var mBackgroundColorInt: Int = Color.BLACK

    // Background color components for openGL
    private var mGLBackgroundColorUnit = OpenGLColorUnit.defUnit

    private val placeholderPaths = mutableListOf<String>()
    private val defaultConfig: ImageConfigInfo
        get() {
            return ImageConfigInfo.newBuilder()
                .setBackgroundColor("0xFF000000")
                .setUseOpenGLRendering(true)
                .setReduceQualityInLowMemory(true)
                .setAndroidAvailableMemoryPercentage(0.1)
                .build()
        }

    val global: ImageConfigInfo get() = mGlobalConfig
    val placeholder: Bitmap? get() = mGlobalPlaceholder
    val errorPlaceholder: Bitmap? get() = mGlobalErrorPlaceholder
    val backgroundColorInt: Int get() = mBackgroundColorInt
    val glBackgroundColorUnit: OpenGLColorUnit get() = mGLBackgroundColorUnit

    fun parseGlobalConfigs(
        context: Context,
        imageConfigInfo: ImageConfigInfo
    ) {
        mGlobalConfig = imageConfigInfo

        parsePlaceholders(context, imageConfigInfo)
        parseBackgroundFillColor(imageConfigInfo)
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

    private fun parsePlaceholders(
        context: Context,
        imageConfigInfo: ImageConfigInfo
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

    private fun parseBackgroundFillColor(imageConfigInfo: ImageConfigInfo) {
        mBackgroundColorInt = with(imageConfigInfo) {
            val colorValue = backgroundColor.replaceFirst("0x", "#")
            assert(colorValue.length == 9) { "Background color format error" }

            if (colorValue.length != 9) {
                Color.BLACK
            }

            Color.parseColor(colorValue)
        }

        mGLBackgroundColorUnit = with(imageConfigInfo) {
            val colorValue = backgroundColor
                .removePrefix("0x")
                .removePrefix("#")

            assert(colorValue.length == 8) { "Background color format error" }

            if (colorValue.length != 8) {
                OpenGLColorUnit.defUnit
            }

            val alpha = colorValue.substring(0, 2).toInt(16) / 255f
            val red = colorValue.substring(2, 4).toInt(16) / 255f
            val green = colorValue.substring(4, 6).toInt(16) / 255f
            val blue = colorValue.substring(6, 8).toInt(16) / 255f

            OpenGLColorUnit(alpha, red, green, blue)
        }
    }
}

class OpenGLColorUnit(
    val alpha: Float,
    val red: Float,
    val green: Float,
    val blue: Float,
) {
    companion object {
        val defUnit: OpenGLColorUnit get() = OpenGLColorUnit(1f, 0f, 0f, 0f)
    }
}