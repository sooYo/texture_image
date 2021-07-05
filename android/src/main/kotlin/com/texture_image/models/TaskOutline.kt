package com.texture_image.models

import android.view.Surface
import coil.request.Disposable
import coil.request.ImageRequest
import com.texture_image.constants.SurfaceTextureEntry
import com.texture_image.constants.TaskState

class TaskOutline(
        var cancelToken: Disposable?,
        var surface: Surface?,
        var state: TaskState?,
        var request: ImageRequest?,
        var retryCount: Int,
        var imageUrl: String,
        var entry: SurfaceTextureEntry
) {
    val isFinished: Boolean
        get() {
            if (state == null) {
                return true
            }

            return state == TaskState.CANCELED ||
                    state == TaskState.COMPLETE ||
                    state == TaskState.FAILED
        }

    val isLoading: Boolean
        get() {
            if (state == null) {
                return false
            }

            return state == TaskState.LOADING
        }
}
