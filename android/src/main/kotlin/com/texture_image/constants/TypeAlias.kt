package com.texture_image.constants

import com.texture_image.image_loader.ImageLoaderTask
import com.texture_image.models.TaskOutline
import io.flutter.view.TextureRegistry

typealias SurfaceTextureEntry = TextureRegistry.SurfaceTextureEntry
typealias TaskMap = LinkedHashMap<Long, ImageLoaderTask> // Surface ID -> ImageLoaderTask
typealias TaskOutlineCache = ArrayDeque<TaskOutline>

