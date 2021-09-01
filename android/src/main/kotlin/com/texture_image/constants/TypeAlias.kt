package com.texture_image.constants

import android.util.LongSparseArray
import android.util.Size
import com.texture_image.image_loader.ImageLoaderTask
import com.texture_image.models.TaskOutline
import io.flutter.view.TextureRegistry

typealias SurfaceTextureEntry = TextureRegistry.SurfaceTextureEntry

@Suppress("unused")
typealias TaskMap = LongSparseArray<ImageLoaderTask>

@Suppress("unused")
typealias TaskReuseMap = LinkedHashMap<Size, MutableList<ImageLoaderTask>> // TextureSize -> ImageLoaderTask list

