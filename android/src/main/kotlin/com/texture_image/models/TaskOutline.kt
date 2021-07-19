package com.texture_image.models

import android.view.Surface
import coil.request.Disposable
import coil.request.ImageRequest
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.proto.ImageUtils.TaskState

class TaskOutline(
    val imageUrl: String,
    val request: ImageRequest,
    val entry: SurfaceTextureEntry,
    val cancelToken: Disposable,
) {
    private var mRetryCount: Int = 0
    private var mSurface: Surface? = null
    private var mState: TaskState = TaskState.initialized

    val retryCount: Int
        get() = mRetryCount

    val surface: Surface?
        get() = mSurface

    val state: TaskState
        get() = mState

    val isFinished: Boolean
        get() {
            return state == TaskState.canceled ||
                    state == TaskState.completed ||
                    state == TaskState.failed
        }

    val isLoading: Boolean
        get() {
            return state == TaskState.loading
        }

    fun retry() {
        ++mRetryCount
    }
}
