//
//  TypeAlias.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/9.
//

#import <UIKit/UIKit.h>
#import "Codes.h"

@protocol ImageProcessor;
@protocol ImageRequest;

#pragma mark -
#pragma mark Functions Alias
/**
 Compltion for processing image
 
 @param image The altered image, maybe nil if something went wrong
 @param error The detail error info if there's any
 */
typedef void (^ImageProcessCompletion) (UIImage * _Nullable image, NSError * _Nullable error);


/**
 Completion of an image loading task
 
 @param request Request that was completed in this callback
 @param image Target image, maybe nil if loading progcess failed
 @param error The detail error info if there's any
 @param isFromCache A boolean indicates whether this image is from local cache or not
 */
typedef void (^ImageLoadingCompletion) (id<ImageRequest> _Nonnull request,  UIImage * _Nullable image, NSError * _Nullable error, BOOL isFromCache);

/**
 Progress notification for a running task
 
 @param request The running requset, you can refer to the current progress from this instance.
 */
typedef void (^ImageLoadProgressCallback) (id<ImageRequest> _Nonnull request);

#pragma mark -
#pragma mark Types Alias

/**
 List of processors
 */
typedef NSArray<id<ImageProcessor>> ImageProcessorList;
