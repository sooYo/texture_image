//
//  Codes.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/11.
//
//  Code list and util methods to make a code-relative error

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, ResultCode) {
    ResultCodeOK = 200,
    ResultCodeUnknown = -1,
    ResultCodeCanceled = -100,
    
    ResultCodeProcessFailed = 100001, // Processor cann't handle the image
};


NS_ASSUME_NONNULL_BEGIN

// TI stands for texture image
@interface TIError : NSError

+ (instancetype)errorWithCode:(ResultCode)code;
+ (instancetype)errorWithCode:(ResultCode)code detail:(NSString * _Nullable)detail;

// Designate constructors
+ (instancetype)processorErrorForType:(NSString *)type url:(NSString *)url;

+ (NSString *)domain;

@end

@implementation TIError

#pragma mark -
#pragma mark Constructors
+ (instancetype)errorWithCode:(ResultCode)code {
    return [TIError errorWithCode:code detail:nil];
}

+ (instancetype)errorWithCode:(ResultCode)code detail:(NSString * _Nullable)detail {
    NSMutableDictionary *customUserInfo = [NSMutableDictionary dictionary];
    NSString *description = [self descriptionForCode:code detail:detail];
    
    if (description != nil) {
        customUserInfo[NSLocalizedDescriptionKey] = description;
    }
    
   return [[TIError alloc] initWithDomain:self.domain code:code userInfo:customUserInfo];
}

#pragma mark -
#pragma mark Designate Constructors
+ (instancetype)processorErrorForType:(NSString *)type url:(NSString *)url {
    NSString *detail = [NSString stringWithFormat: @"%@ cannot handle image from %@", type, url];
    return [TIError errorWithCode:ResultCodeProcessFailed detail:detail];
}

#pragma mark -
#pragma mark Helper Methods
+ (NSString *)domain {
    return @"TextImageError";
}

+ (NSString *)descriptionForCode:(ResultCode)code detail:(NSString * _Nullable)detail {
    NSString *result = nil;
    
    switch (code) {
        case ResultCodeOK:
            result = @"Everything is fine, this is not an error at all";
        case ResultCodeUnknown:
            result = @"Unknown error";
        case ResultCodeCanceled:
            result = @"Task or other routine had been cancled";
        case ResultCodeProcessFailed:
            result = @"Processor cannot handle this image";
        default:
            result = [NSString stringWithFormat:@"It's a valid reuslt code: %zd", code];
    }
    
    if (detail != nil) {
        result = [NSString stringWithFormat:@"%@. Detail: %@", result, detail];
    }
    
    return result;
}

@end

NS_ASSUME_NONNULL_END
