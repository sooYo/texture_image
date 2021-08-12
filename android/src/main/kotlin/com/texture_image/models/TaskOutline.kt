package com.texture_image.models

import android.graphics.SurfaceTexture
import android.view.Surface
import coil.request.Disposable
import coil.request.ImageRequest
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.proto.ImageUtils.TaskState

class TaskOutline(
    val imageUrl: String,
    val surface: Surface? = null,
    val request: ImageRequest? = null,
    val cancelToken: Disposable? = null,
    val entry: SurfaceTextureEntry? = null,
    val texture: SurfaceTexture? = null,
    val state: TaskState = TaskState.initialized
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
        builder.request,
        builder.cancelToken,
        builder.entry,
        builder.texture,
        builder.state,
    )

    val id: Long get() = entry?.id() ?: -1
    val isLoading: Boolean get() = state == TaskState.loading
    val isCompleted: Boolean get() = state == TaskState.completed
    val isInitialized: Boolean get() = state == TaskState.initialized

    fun release() {
        surface?.release()
        entry?.release()
        cancelToken?.dispose()
        texture?.release()
    }
}

class TaskOutlineBuilder {
    lateinit var imageUrl: String
    var request: ImageRequest? = null
    var cancelToken: Disposable? = null
    var state: TaskState = TaskState.initialized

    var entry: SurfaceTextureEntry? = null
    var texture: SurfaceTexture? = null
    var surface: Surface? = null

    fun clone(outline: TaskOutline?) = apply {
        if (outline != null) {
            imageUrl = outline.imageUrl
            request = outline.request
            entry = outline.entry
            cancelToken = outline.cancelToken
            surface = outline.surface
            state = outline.state
            texture = outline.texture
        }
    }

    fun setImageUrl(imageUrl: String) = apply {
        this.imageUrl = imageUrl
    }

    fun setRequest(request: ImageRequest?) = apply {
        this.request = request
    }

    fun setEntry(entry: SurfaceTextureEntry?) = apply {
        this.entry = entry
    }

    fun setCancelToken(cancelToken: Disposable?) = apply {
        this.cancelToken = cancelToken
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
