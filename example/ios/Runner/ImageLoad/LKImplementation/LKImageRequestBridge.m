//
//  LKImageRequestBridge.m
//  TextureImage
//
//  Created by Sooyo on 2021/10/11.
//

#import <LKImageKit/LKImageKit.h>

#import "LKImageRequestBridge.h"

@interface LKImageRequestBridge ()

@property (nonatomic, strong) LKImageRequest * driver;

@end

@implementation LKImageRequestBridge

@dynamic url;
@dynamic state;
@dynamic cacheEnable;
@dynamic progress;
@dynamic preferedSize;

@synthesize processors = _processors;

- (instancetype)initWithURL:(NSString *)url {
    if (url == nil || url.length == 0) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _driver = [LKImageURLRequest requestWithURL:url];
    }
    
    return self;
}

- (instancetype)initWithLKRequest:(LKImageRequest *)request {
    if (![request isKindOfClass:LKImageRequest.class]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _driver = request;
    }
    
    return self;
}

- (NSString *)url {
    if (![_driver isKindOfClass:LKImageURLRequest.class]) {
        return nil;
    }
        
    return ((LKImageURLRequest *)_driver).URL;
}

- (ImageLoadState)state {
    ImageLoadState result = ImageLoadStateInitailized;
    
    switch (_driver.state) {
        case LKImageRequestStateFinish:
            result = _driver.error != nil ? ImageLoadStateSuccess : ImageLoadStateFailed;
            break;
        case LKImageRequestStateLoading:
            result = ImageLoadStateLoading;
            break;
        default:
            break;
    }
    
    if (result == ImageLoadStateInitailized && _driver.isCanceled) {
        result = ImageLoadStateCanceled;
    }
    
    return result;
}

- (BOOL)cacheEnable {
    return _driver.cacheEnabled;
}

- (void)setCacheEnable:(BOOL)cacheEnable {
    _driver.cacheEnabled = cacheEnable;
}

- (CGSize)preferedSize {
    return _driver.preferredSize;
}

- (void)setPreferedSize:(CGSize)preferedSize {
    _driver.preferredSize = preferedSize;
}

- (CGFloat)progress {
    return _driver.progress;
}

@end
