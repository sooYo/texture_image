package com.texture_image.render

import android.graphics.Bitmap
import com.texture_image.models.TaskOutline

interface Renderer {
    val isReleased: Boolean

    fun render(
        bitmap: Bitmap,
        srcWidth: Int,
        srcHeight: Int,
        taskContext: TaskOutline,
    )

    fun release()
}