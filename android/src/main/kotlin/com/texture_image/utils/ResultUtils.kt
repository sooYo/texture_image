package com.texture_image.utils

import com.texture_image.constants.ErrorCode
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo
import com.texture_image.proto.ImageUtils

object ResultUtils {
    val ok: ByteArray
        get() = makeResult(ErrorCode.OK, "Success")

    val archived: ByteArray
        get() = makeResult(
            ErrorCode.TASK_HAS_BEEN_REUSED,
            "Task has been reused, current loading mission should be cancelled",
            state = ImageUtils.TaskState.prepreReuse
        )

    val httpTooLate: ByteArray
        get() = makeResult(
            ErrorCode.DISPOSED_BEFORE_HTTP_RESPONSES,
            "Task replied too late and widget is being disposed at this time",
            state = ImageUtils.TaskState.failed
        )

    private fun makeResult(
        code: ErrorCode,
        message: String,
        url: String? = null,
        textureId: Long? = null,
        state: ImageUtils.TaskState? = null
    ): ByteArray {
        return ImageInfo.ResultInfo.newBuilder()
            .setCode(code.code)
            .setMessage(message)
            .setUrl(url ?: "")
            .setTextureId(textureId ?: -1)
            .setState(state ?: ImageUtils.TaskState.completed)
            .build()
            .toByteArray()
    }

    // region Concrete Makers
    fun success(outline: TaskOutline?): ByteArray {
        return makeResult(
            ErrorCode.OK,
            "success",
            outline?.imageUrl,
            outline?.id,
            outline?.state
        )
    }

    fun protoParseFailed(clz: String, method: String): ByteArray {
        val message = "$method: Parse PB ($clz) data failed"
        return makeResult(ErrorCode.PB_PARSE_FAILED, message)
    }

    fun argTypeError(
        method: String,
        argument: String,
        expected: String? = null
    ): ByteArray {
        val message =
            "$method: Argument ($argument) type error${if (expected != null) ", excepted: $expected" else ""}"
        return makeResult(ErrorCode.ARGUMENT_TYPE_ERROR, message)
    }
    // endregion Concrete Makers
}