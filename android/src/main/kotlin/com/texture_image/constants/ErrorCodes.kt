/// Error code list
///
/// This file is generated by shell script on 2021-10-08, please don't edit this file manually

package com.texture_image.constants

enum class ErrorCode(val code: Int) {
    // Success
    OK(200),
    
    // Cannot parse PB data
    PB_PARSE_FAILED(100001),
    
    // Arguments from channel method params map with a wrong data type
    ARGUMENT_TYPE_ERROR(100002),
    
    // The task has been reused and previous loading mission should be cancelled
    TASK_HAS_BEEN_REUSED(100003),
    
    // Image widget has been disposed before its attached fetching task completed
    DISPOSED_BEFORE_HTTP_RESPONSES(100004),
    
}