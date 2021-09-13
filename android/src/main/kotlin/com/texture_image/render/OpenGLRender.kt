package com.texture_image.render

import android.graphics.Bitmap
import android.graphics.SurfaceTexture
import android.opengl.GLES20
import android.opengl.GLUtils
import android.os.Handler
import android.os.HandlerThread
import com.texture_image.extensions.*
import com.texture_image.models.TaskOutline
import com.texture_image.proto.ImageInfo
import com.texture_image.proto.ImageUtils
import com.texture_image.proto.ImageUtils.BoxFit.*
import javax.microedition.khronos.egl.*

/**
 * A simple render using OpenGL drawing images into target [SurfaceTexture]
 */
class OpenGLRender(
    taskContext: TaskOutline,
    private val geometry: ImageUtils.Geometry,
) : Renderer {
    private var handler: Handler? = null
    private var handlerThread: HandlerThread? = null
    private val shaderProgram: Shader = Shader(taskContext.id)

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
        if (taskContext.texture == null) {
            throw RuntimeException("Cannot create render with a null texture!")
        }

        mIsReleased = false
        handlerThread = HandlerThread("texture_image_plugin_render")
        handlerThread!!.start()
        handler = Handler(handlerThread!!.looper)
        handler?.post { initOpenGL(taskContext.texture) }
    }

    override val isReleased: Boolean
        get() = mIsReleased

    override fun render(
        bitmap: Bitmap,
        srcWidth: Int,
        srcHeight: Int,
        taskContext: TaskOutline,
        globalConfig: ImageInfo.ImageConfigInfo,
    ) {
        handler?.post {
            if (shaderProgram.matrixLocation != 0) {
                GLES20.glUniformMatrix4fv(
                    shaderProgram.matrixLocation,
                    1,
                    false,
                    openglMatrixBuffer(bitmap, srcWidth, srcHeight),
                    0
                )
            }

            if (!bitmap.isRecycled) {
                GLUtils.texImage2D(GLES20.GL_TEXTURE_2D, 0, bitmap, 0)
            }

            GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, Shader.vertexCount)
            egl.eglSwapBuffers(eglDisplay, eglSurface)
        }
    }

    override fun release() {
        mIsReleased = true
        handler?.post { releaseOpengl() }
        handlerThread?.quitSafely()
        handlerThread?.join()
    }

    private fun releaseOpengl() {
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

    // region Bitmap Fitting
    private fun openglMatrixBuffer(
        bitmap: Bitmap,
        width: Int,
        height: Int
    ): FloatArray {
        with(bitmap) {
            return when (geometry.fit) {
                fitHeight -> matrixBufferBoxFitFitHeight(width, height)
                fitWidth -> matrixBufferBoxFitFitWidth(width, height)
                cover -> matrixBufferBoxFitCover(width, height)
                contain -> matrixBufferBoxFitContains(width, height)
                else -> matrixBufferBoxFitFill(width, height)
            }
        }
    }
    // endregion Bitmap Fitting
}