package com.texture_image.constants

import com.texture_image.image_loader.ImageLoaderTask
import com.texture_image.models.TaskOutline
import io.flutter.view.TextureRegistry

typealias SurfaceTextureEntry = TextureRegistry.SurfaceTextureEntry
typealias SurfaceTextureMap = LinkedHashMap<String, SurfaceTextureEntry>
typealias ImageLoadCallback = (Map<String, String>) -> Unit

/**
 * A map referring to a [ImageLoaderTask] by its charged surface ID
 */
typealias LoaderTaskMap = LinkedHashMap<Long, TaskOutline>