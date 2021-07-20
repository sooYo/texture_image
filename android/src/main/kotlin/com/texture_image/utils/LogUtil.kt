package com.texture_image.utils

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

object LogUtil {
    private const val TAG = "TextureImage"
    private var enable: Boolean = true

    fun enableLog(
        @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        var code = 0
        enable = try {
            call.argument<Boolean>("enable") ?: false
        } catch (e: Exception) {
            code = -1
            false
        }

        result.success(code)
    }

    fun w(message: String) {
        if (enable) Log.w(TAG, message)
    }

    fun d(message: String) {
        if (enable) Log.d(TAG, message)
    }

    fun i(message: String) {
        if (enable) Log.i(TAG, message)
    }

    fun e(message: String) {
        if (enable) Log.e(TAG, message)
    }
}