/// Plugin API list
///
/// This file is generated by shell script on 2021-09-01, please don't edit this file manually

package com.texture_image.constants

class Methods {
    companion object {
        // Create a new texture image base on a [ImageFetchInfo]
        const val createImageTexture = "createImageTexture"
        
        // Release or cache resource of a texture image once the widget nis disposed, param is of [ImageFetchCancelInfo] type
        const val disposeImageTexture = "disposeImageTexture"
        
        // Sets the global config of the plugin, the config detail please refer to [ImageConfigInfo]
        const val textureImageConfig = "textureImageConfig"
        
        // Release all texures waiting in the to-be-reused queue, has no effect on those occupied by Flutter widgets
        const val releaseImageTextureCaches = "releaseImageTextureCaches"
        
        // Enable/disable console log, param is a boolean
        const val enableLog = "enableLog"
        
    }
}