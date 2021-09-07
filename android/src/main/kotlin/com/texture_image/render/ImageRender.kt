package com.texture_image.render

import android.graphics.Bitmap
import android.graphics.SurfaceTexture
import android.opengl.GLES20
import android.opengl.GLUtils
import android.os.Handler
import android.os.HandlerThread
import javax.microedition.khronos.egl.*

class ImageRender(
    textureId: Long,
    texture: SurfaceTexture,
) {
    private val handler: Handler
    private val handlerThread = HandlerThread("Render")
    private val shaderProgram: Shader = Shader(textureId)

    private lateinit var egl: EGL10
    private lateinit var eglDisplay: EGLDisplay
    private lateinit var eglContext: EGLContext
    private lateinit var eglSurface: EGLSurface

    private var mIsReleased = false

    private
    val eglConfigAttrs: IntArray
        get() = intArrayOf(
            EGL10.EGL_RENDERABLE_TYPE, 4,
            EGL10.EGL_SAMPLE_BUFFERS, 1,
            EGL10.EGL_SAMPLES, 4,
            EGL10.EGL_RED_SIZE, 8,
            EGL10.EGL_GREEN_SIZE, 8,
            EGL10.EGL_BLUE_SIZE, 8,
            EGL10.EGL_ALPHA_SIZE, 8,
            EGL10.EGL_DEPTH_SIZE, 16,
            EGL10.EGL_STENCIL_SIZE, 0,
            EGL10.EGL_NONE
        )

    init {
        handlerThread.start()
        handler = Handler(handlerThread.looper)
        handler.post { init(texture) }
    }

    fun render(bitmap: Bitmap) {
        handler.post {
            if (!bitmap.isRecycled) {
                GLUtils.texImage2D(GLES20.GL_TEXTURE_2D, 0, bitmap, 0)
            }

            GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, Shader.vertexCount)
            egl.eglSwapBuffers(eglDisplay, eglSurface)
        }
    }

    fun release() {
        mIsReleased = true
        handler.post { dispose() }
        handlerThread.quitSafely()
        handlerThread.join()
    }

    private fun init(texture: SurfaceTexture) {
        initOpenGL(texture)
        initShaderProgram()
    }

    private fun dispose() {
        egl.eglWaitGL()
        egl.eglMakeCurrent(
            eglDisplay,
            EGL10.EGL_NO_SURFACE,
            EGL10.EGL_NO_SURFACE,
            EGL10.EGL_NO_CONTEXT
        )

        egl.eglDestroySurface(eglDisplay, eglSurface)
        egl.eglDestroyContext(eglDisplay, eglContext)
        egl.eglTerminate(eglDisplay)
    }

    // region Init Routine
    private fun initOpenGL(texture: SurfaceTexture) {
        egl = (EGLContext.getEGL() as EGL10)
        eglDisplay = egl.eglGetDisplay(EGL10.EGL_DEFAULT_DISPLAY).also {
            if (it == EGL10.EGL_NO_DISPLAY) {
                throw RuntimeException("Cannot get default EGLDisplay")
            }
        }

        val version = IntArray(2)
        if (!egl.eglInitialize(eglDisplay, version)) {
            throw RuntimeException("Cannot initialize EGLDisplay")
        }

        val eglConfig = chooseEglConfig()
        eglContext = createEGLContext(eglConfig).also {
            if (it == EGL10.EGL_NO_CONTEXT) {
                throw RuntimeException("Cannot create EGLContext")
            }
        }

        eglSurface = egl.eglCreateWindowSurface(
            eglDisplay,
            eglConfig,
            texture,
            null
        ).also {
            if (it == null || it == EGL10.EGL_NO_SURFACE) {
                throw RuntimeException("Cannot create EGLSurface")
            }
        }

        val makeCurrent = egl.eglMakeCurrent(
            eglDisplay,
            eglSurface,
            eglSurface,
            eglContext
        )

        if (!makeCurrent) {
            throw RuntimeException("Cannot attach context to surfaces")
        }
    }

    private fun initShaderProgram() {
        shaderProgram.prepareShaderProgram()
    }

// endregion Init Routine

    // region EGL Helpers
    private fun chooseEglConfig(): EGLConfig? {
        val configsCount = IntArray(1)
        val configs = arrayOfNulls<EGLConfig>(1)
        val chooseResult = egl.eglChooseConfig(
            eglDisplay,
            eglConfigAttrs,
            configs,
            1,
            configsCount
        )

        if (!chooseResult) {
            throw RuntimeException("EGLChooseConfig failed")
        }

        return when (configsCount[0] > 0) {
            true -> configs[0]
            else -> null
        }
    }

    private fun createEGLContext(
        config: EGLConfig?,
        version: Int = 2
    ): EGLContext {
        val eglClientVersion = 0x3098
        val attrs = intArrayOf(eglClientVersion, version, EGL10.EGL_NONE)
        return egl.eglCreateContext(
            eglDisplay,
            config,
            EGL10.EGL_NO_CONTEXT,
            attrs
        )
    }
// endregion EGL Helpers
}