package com.texture_image.constants

enum class ErrorCode(val code: Int) {
    OK(200),

    PB_PARSE_FAILED(100001),

    ARGUMENT_TYPE_ERROR(100002),
}