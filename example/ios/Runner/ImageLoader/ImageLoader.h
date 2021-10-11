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

+ (instancetype)defaultLoader;

- (void)sendRequest:(id<ImageRequestProtol>)request withCompletion:(ImageLoadingCompletion)completion;
- (void)cancelRequest:(id<ImageRequestProtol>)request;

@end

NS_ASSUME_NONNULL_END
