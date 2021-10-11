//
//  TIError.m
//  Runner
//
//  Created by Sooyo on 2021/10/11.
//

#import "TIError.h"

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
