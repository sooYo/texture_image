package com.texture_image.image_loader

import coil.request.Disposable

interface LoaderTaskScheduler {
    /**
     * To trigger the request
     */
    fun schedule(task: ImageLoaderTask): Disposable?

    /**
     * Delegate outline changing to this object
     */
    fun onTaskStateUpdated(task: ImageLoaderTask)
}