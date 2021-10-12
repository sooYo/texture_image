//
//  Utils.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/12.
//
//  Utility functions collection

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

/**
 Check if the invoking context is on the main queue
 
 This is usually used to check if we're on main thread
 */
+ (BOOL)isOnMainQueue;

@end

NS_ASSUME_NONNULL_END
