package com.texture_image.utils

import com.texture_image.constants.ErrorCode
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo
import com.texture_image.proto.ImageUtils

object ResultUtils {
    private fun makeResult(
            code: ErrorCode,
            message: String,
            url: String? = null,
            textureId: Long? = null,
            state: ImageUtils.TaskState? = null
    ): ByteArray {
        return ImageInfo.ImageFetchResultInfo.newBuilder()
                .setCode(code.code)
                .setMessage(message)
                .setUrl(url ?: "")
                .setTextureId(textureId ?: -1)
                .setState(state)
                .build()
                .toByteArray()
    }

    // region Concrete Makers
    fun success(outline: TaskOutline): ByteArray {
        return makeResult(ErrorCode.OK, "success", outline.imageUrl, outline.entry.id(), outline.state)
    }

    fun protoParseFailed(clz: String, method: String): ByteArray {
        val message = "$method: Parse PB ($clz) data failed"
        return makeResult(ErrorCode.PB_PARSE_FAILED, message)
    }

    fun argTypeError(method: String, argument: String, expected: String? = null): ByteArray {
        val message = "$method: Argument ($argument) type error${if (expected != null) ", excepted: $expected" else ""}"
        return makeResult(ErrorCode.ARGUMENT_TYPE_ERROR, message)
    }
    // endregion Concrete Makers
}