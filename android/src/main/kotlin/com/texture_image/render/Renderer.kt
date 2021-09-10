package com.texture_image.render

import android.graphics.Bitmap
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo

interface Renderer {
    fun render(
        bitmap: Bitmap,
        srcWidth: Int,
        srcHeight: Int,
        taskContext: TaskOutline,
        globalConfig: ImageInfo.ImageConfigInfo
    )

    fun release()
}