//
//  TIError.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/11.
//
//  TI stands for texture image

#import <Foundation/Foundation.h>
#import "Codes.h"

NS_ASSUME_NONNULL_BEGIN

@interface TIError : NSError

+ (instancetype)errorWithCode:(ResultCode)code;
+ (instancetype)errorWithCode:(ResultCode)code detail:(NSString * _Nullable)detail;

// Designate constructors
+ (instancetype)processorErrorForType:(NSString *)type url:(NSString *)url;

+ (NSString *)domain;

@end

NS_ASSUME_NONNULL_END
