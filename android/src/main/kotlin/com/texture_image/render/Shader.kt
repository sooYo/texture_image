package com.texture_image.render

import android.opengl.GLES20
import com.texture_image.utils.ConfigUtil
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.nio.FloatBuffer

class Shader(private val textureId: Long) {
    companion object {
        private const val vertexCoors = 3
        const val fragmentSource =
            "precision mediump float;\n" +
                    "varying vec2 v_texPo;\n" +
                    "uniform sampler2D sTexture;\n" +
                    "void main() {\n" +
                    "    gl_FragColor=texture2D(sTexture, v_texPo);\n" +
                    "}"

        const val vertexSource =
            "attribute vec4 av_Position;\n" +
                    "attribute vec2 af_Position;\n" +
                    "varying vec2 v_texPo;\n" +
                    "uniform mat4 v_matrix;\n" +
                    "void main() {\n" +
                    "    v_texPo = af_Position;\n" +
                    "    gl_Position = av_Position * v_matrix;\n" +
                    "}"

        private val vertexData = floatArrayOf(
            -1f, -1f, 0.0f,
            1f, -1f, 0.0f,
            -1f, 1f, 0.0f,
            1f, 1f, 0.0f,
        )

        private val textureData = floatArrayOf(
            0f, 1f, 0.0f,
            1f, 1f, 0.0f,
            0f, 0f, 0.0f,
            1f, 0f, 0.0f,
        )

        val vertexCount = vertexData.size / vertexCoors
        const val vertexStride = vertexCoors * 4
    }

    private lateinit var vertexBuffer: FloatBuffer
    private lateinit var textureBuffer: FloatBuffer

    private var program: Int = 0
    private var vertexShader: Int = 0
    private var fragmentShader: Int = 0

    var matrixLocation: Int = 0

    fun prepareShaderProgram() {
        program = compileAndLinkShaders().also {
            if (it == 0) {
                throw RuntimeException("Create shader program failed")
            }
        }

        bindProgramToTextureEnv()
    }

    private fun loadShader(shaderType: Int, shaderSource: String): Int {
        var shader = GLES20.glCreateShader(shaderType)
        if (shader != 0) {
            GLES20.glShaderSource(shader, shaderSource)
            GLES20.glCompileShader(shader)

            val compile = intArrayOf(1)

            GLES20.glGetShaderiv(shader, GLES20.GL_COMPILE_STATUS, compile, 0)
            if (compile[0] != GLES20.GL_TRUE) {
                GLES20.glDeleteShader(shader)
                shader = 0
            }
        }

        return shader
    }

    private fun compileAndLinkShaders(): Int {
        vertexShader = loadShader(GLES20.GL_VERTEX_SHADER, vertexSource)
        if (vertexShader == 0) {
            return 0
        }

        fragmentShader = loadShader(GLES20.GL_FRAGMENT_SHADER, fragmentSource)
        if (fragmentShader == 0) {
            return 0
        }

        var program = GLES20.glCreateProgram()
        if (program != 0) {
            GLES20.glAttachShader(program, vertexShader)
            GLES20.glAttachShader(program, fragmentShader)
            GLES20.glLinkProgram(program)

            val status = intArrayOf(1)
            GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, status, 0)

            if (status[0] != GLES20.GL_TRUE) {
                GLES20.glDeleteProgram(program)
                program = 0
            }
        }

        return program
    }

    private fun bindProgramToTextureEnv() {
        createTextureBuffers()
        configTextureFilters()

        val avPosition = GLES20.glGetAttribLocation(program, "av_Position")
        val afPosition = GLES20.glGetAttribLocation(program, "af_Position")

        matrixLocation = GLES20.glGetUniformLocation(program, "v_matrix")

        with(ConfigUtil.glBackgroundColorUnit) {
            GLES20.glClearColor(red, green, blue, alpha)
        }

        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT or GLES20.GL_DEPTH_BUFFER_BIT)
        GLES20.glUseProgram(program)
        GLES20.glEnableVertexAttribArray(avPosition)
        GLES20.glEnableVertexAttribArray(afPosition)

        GLES20.glVertexAttribPointer(
            avPosition,
            vertexCoors,
            GLES20.GL_FLOAT,
            false,
            vertexStride,
            vertexBuffer
        )

        GLES20.glVertexAttribPointer(
            afPosition,
            vertexCoors,
            GLES20.GL_FLOAT,
            false,
            vertexStride,
            textureBuffer
        )
    }

    private fun createTextureBuffers() {
        vertexBuffer = ByteBuffer
            .allocateDirect(vertexData.size * 4)
            .order(ByteOrder.nativeOrder())
            .asFloatBuffer()
            .put(vertexData)
            .apply { position(0) }

        textureBuffer = ByteBuffer
            .allocateDirect(textureData.size * 4)
            .order(ByteOrder.nativeOrder())
            .asFloatBuffer()
            .put(textureData)
            .apply { position(0) }
    }

    private fun configTextureFilters() {
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, textureId.toInt())
        GLES20.glTexParameteri(
            GLES20.GL_TEXTURE_2D,
            GLES20.GL_TEXTURE_WRAP_S,
            GLES20.GL_CLAMP_TO_EDGE
        )

        GLES20.glTexParameteri(
            GLES20.GL_TEXTURE_2D,
            GLES20.GL_TEXTURE_WRAP_T,
            GLES20.GL_CLAMP_TO_EDGE
        )

        GLES20.glTexParameteri(
            GLES20.GL_TEXTURE_2D,
            GLES20.GL_TEXTURE_MIN_FILTER,
            GLES20.GL_LINEAR
        )

        GLES20.glTexParameteri(
            GLES20.GL_TEXTURE_2D,
            GLES20.GL_TEXTURE_MAG_FILTER,
            GLES20.GL_LINEAR
        )
    }
}