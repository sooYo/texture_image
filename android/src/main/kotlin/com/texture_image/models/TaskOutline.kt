package com.texture_image.models

import android.graphics.SurfaceTexture
import android.view.Surface
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.proto.ImageUtils.TaskState

class TaskOutline(
    val imageUrl: String,
    val surface: Surface? = null,
    val entry: SurfaceTextureEntry? = null,
    val texture: SurfaceTexture? = null,
    val state: TaskState = TaskState.initialized,
) {
    companion object {
        val undefined = TaskOutline(
            imageUrl = "",
            state = TaskState.undefined
        )
    }

    constructor(builder: TaskOutlineBuilder) : this(
        builder.imageUrl,
        builder.surface,
        builder.entry,
        builder.texture,
        builder.state,
    )

    val id: Long get() = entry?.id() ?: -1

    @Suppress("unused")
    val isLoading: Boolean
        get() = state == TaskState.loading

    @Suppress("unused")
    val isCompleted: Boolean
        get() = state == TaskState.completed || state == TaskState.failed

    val isInitialized: Boolean get() = state == TaskState.initialized

    fun release(maybeReuse: Boolean = false) {
        if (!maybeReuse) {
            surface?.release()
            entry?.release()
            texture?.release()
        }
    }
}

class TaskOutlineBuilder {
    lateinit var imageUrl: String

    var entry: SurfaceTextureEntry? = null
    var texture: SurfaceTexture? = null
    var surface: Surface? = null
    var state: TaskState = TaskState.initialized

    fun clone(outline: TaskOutline?) = apply {
        if (outline != null) {
            imageUrl = outline.imageUrl
            entry = outline.entry
            surface = outline.surface
            state = outline.state
            texture = outline.texture
        }
    }

    fun setImageUrl(imageUrl: String) = apply {
        this.imageUrl = imageUrl
    }

    fun setEntry(entry: SurfaceTextureEntry?) = apply {
        this.entry = entry
    }

    fun setSurface(surface: Surface?) = apply {
        this.surface = surface
    }

    fun setState(state: TaskState) = apply {
        this.state = state
    }

    fun setTexture(texture: SurfaceTexture?) = apply {
        this.texture = texture
    }

    fun build(): TaskOutline {
        return TaskOutline(builder = this)
    }
}
