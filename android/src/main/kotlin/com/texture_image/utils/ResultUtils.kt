package com.texture_image.utils

import com.texture_image.constants.ErrorCode
import com.texture_image.constants.TaskState
import com.texture_image.models.TaskOutline
import com.texture_image.proto.Enum
import com.texture_image.proto.MethodCallResult

object ResultUtils {
    private fun makeResult(
            code: ErrorCode,
            message: String,
            url: String? = null,
            textureId: Long? = null,
            state: TaskState? = null
    ): ByteArray {
        val resultState = when (state) {
            TaskState.LOADING -> Enum.ImageTaskState.loading
            TaskState.FAILED -> Enum.ImageTaskState.failed
            TaskState.COMPLETE -> Enum.ImageTaskState.completed
            TaskState.CANCELED -> Enum.ImageTaskState.canceled
            TaskState.INITIALIZED -> Enum.ImageTaskState.initialized
            else -> Enum.ImageTaskState.UNRECOGNIZED
        }

        return MethodCallResult.ImageResult.newBuilder()
                .setCode(code.code)
                .setMessage(message)
                .setUrl(url ?: "")
                .setTextureId(textureId ?: -1)
                .setState(resultState)
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