//
//  ImageLoader.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/9.
//
//  A common protocol of different image loaders from different frameworks

#import <Foundation/Foundation.h>

#import "TypeAlias.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ImageLoader <NSObject>

// The max concurrent loading tasks count, range is [1, 10]
@property (nonatomic, assign) NSInteger maxConcurrentCount;

// The max seconds to wait for network reponses
@property (nonatomic, assign) NSInteger timeoutInterval;

// The max memory cahche size in Megabytes
@property (nonatomic, assign) NSInteger maxCacheSize;

// Retry limit for each request sent by this loader
@property (nonatomic, assign) NSInteger retryCount;

- (void)sendRequest:(id<ImageRequest>)request
 withProgressNotify:(ImageLoadProgressCallback _Nullable)onProgress
      andCompletion:(ImageLoadingCompletion)completion;

- (void)cancelRequest:(id<ImageRequest>)request;

@end

NS_ASSUME_NONNULL_END
