package com.texture_image

import androidx.annotation.NonNull
import com.texture_image.constants.Methods
import com.texture_image.image_loader.ImageLoader
import com.texture_image.utils.LogUtil
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TextureImagePlugin */
class TextureImagePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var _imageLoader: ImageLoader? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "texture_image"
        )

        channel.setMethodCallHandler(this)

        _imageLoader = ImageLoader(
            flutterPluginBinding.applicationContext,
            flutterPluginBinding.textureRegistry
        )
    }

    override fun onMethodCall(
        @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        when (call.method) {
            Methods.createImageTexture -> _imageLoader?.createTextureImage(
                call,
                result
            )
            Methods.destroyImageTexture -> _imageLoader?.disposeTextureImage(
                call,
                result
            )
            Methods.textureImageConfig -> _imageLoader?.updateGlobalConfig(
                call,
                result
            )
            Methods.enableLog -> LogUtil.enableLog(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
