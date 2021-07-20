package com.texture_image.models

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
        builder.state,
    )

    val id: Long get() = entry?.id() ?: -1
    val isCompleted: Boolean get() = state == TaskState.completed
    val isInitialized: Boolean get() = state == TaskState.initialized

    val didStop: Boolean
        get() {
            return state == TaskState.canceled ||
                    state == TaskState.completed ||
                    state == TaskState.failed
        }

    val isReusable: Boolean
        get() {
            return entry != null &&
                    surface != null &&
                    state != TaskState.failed &&
                    state != TaskState.canceled
        }

    fun release() {
        surface?.release()
        entry?.release()
        cancelToken?.dispose()
    }
}

class TaskOutlineBuilder {
    lateinit var imageUrl: String
    var request: ImageRequest? = null
    var entry: SurfaceTextureEntry? = null
    var cancelToken: Disposable? = null
    var surface: Surface? = null
    var state: TaskState = TaskState.initialized

    fun clone(outline: TaskOutline?): TaskOutlineBuilder {
        if (outline != null) {
            imageUrl = outline.imageUrl
            request = outline.request
            entry = outline.entry
            cancelToken = outline.cancelToken
            surface = outline.surface
            state = outline.state
        }

        return this
    }

    fun setImageUrl(imageUrl: String): TaskOutlineBuilder {
        this.imageUrl = imageUrl
        return this
    }

    fun setRequest(request: ImageRequest?): TaskOutlineBuilder {
        this.request = request
        return this
    }

    fun setEntry(entry: SurfaceTextureEntry?): TaskOutlineBuilder {
        this.entry = entry
        return this
    }

    fun setCancelToken(cancelToken: Disposable?): TaskOutlineBuilder {
        this.cancelToken = cancelToken
        return this
    }

    fun setSurface(surface: Surface?): TaskOutlineBuilder {
        this.surface = surface
        return this
    }

    fun setState(state: TaskState): TaskOutlineBuilder {
        this.state = state
        return this
    }

    fun build(): TaskOutline {
        return TaskOutline(builder = this)
    }
}
