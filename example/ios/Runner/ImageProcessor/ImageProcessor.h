//
//  ImageProcessor.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/9.
//
//  A protocol for processors altering the outcome image. It receives a raw image and
//  provides a altered image after some particular processing or transformation, like
//  grayscale，rounded rect cliping, blur effect, etc.

#import "TypeAlias.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ImageProcessor <NSObject>

@property (nonatomic, copy, readonly) NSString *identifier;

- (void)processImage:(UIImage *)image withCompletion:(ImageProcessCompletion)completion;

@end

NS_ASSUME_NONNULL_END
