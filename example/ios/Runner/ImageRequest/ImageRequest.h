//
//  ImageRequest.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/9.
//
//  A protol to shrink the gap between image requests of different image loading frameworks.

#import <Foundation/Foundation.h>

#import "TypeAlias.h"
#import "ImageLoadState.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ImageRequestProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *url;

// Processors to handle the image after fetching
@property (nonatomic, strong) ImageProcessorList *processors;

@property (nonatomic, assign) ImageLoadState state;
@property (nonatomic, assign) CGSize preferedSize;
@property (nonatomic, assign) BOOL cacheEnable;

// Retry control
@property (nonatomic, assign) NSInteger retryCount;

@end

NS_ASSUME_NONNULL_END
