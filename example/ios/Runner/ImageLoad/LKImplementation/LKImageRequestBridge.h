//
//  LKImageRequestBridge.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/11.
//
//  Image request backed by LKImageRequest under the hood

#import <Foundation/Foundation.h>

#import "ImageRequest.h"

@class LKImageRequest;

NS_ASSUME_NONNULL_BEGIN

@interface LKImageRequestBridge : NSObject <ImageRequest>

@property (nonatomic, strong, readonly) LKImageRequest * driver;

- (instancetype)init NS_UNAVAILABLE; // Please use designate initializers

- (instancetype)initWithURL:(NSString *)url;
- (instancetype)initWithLKRequest:(LKImageRequest *)request;

@end

NS_ASSUME_NONNULL_END
