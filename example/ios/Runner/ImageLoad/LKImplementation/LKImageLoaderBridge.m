//
//  LKImageLoaderBridge.m
//  Runner
//
//  Created by Sooyo on 2021/10/11.
//

#import <LKImageKit/LKImageKit.h>

#import "ImageRequest.h"
#import "Macros.h"
#import "TIError.h"

#import "LKImageLoaderBridge.h"
#import "LKImageRequestBridge.h"

@interface LKImageLoaderBridge ()

@property (nonatomic, strong) LKImageNetworkFileLoader *networkLoader;
@property (nonatomic, strong) LKImageMemoryCache *memoryCache;

@end

@implementation LKImageLoaderBridge

@dynamic retryCount;
@dynamic maxCacheSize;
@dynamic timeoutInterval;
@dynamic maxConcurrentCount;

- (instancetype)init {
    self = [super init];
    if (self) {
        _memoryCache = [[LKImageMemoryCache alloc] init];
        _networkLoader = [[LKImageNetworkFileLoader alloc] init];
            
        LKImageLocalFileLoader *localLoader = [[LKImageLocalFileLoader alloc] init];
        LKImageSystemDecoder *decoder = [[LKImageSystemDecoder alloc] init];
        
        [self.driver.cacheManager registerCache:_memoryCache];
        [self.driver.loaderManager registerLoader:localLoader];
        [self.driver.loaderManager registerLoader:_networkLoader];
        [self.driver.loaderManager.decoderManager registerDecoder:decoder];
        
        self.retryCount = 3;
        self.maxCacheSize = 50;
        self.maxConcurrentCount = 3;
        self.timeoutInterval = 30;
    }
    
    return self;
}

- (void)dealloc {
    [self.driver.cacheManager unregisterAllCache];
    [self.driver.loaderManager unregisterAllLoader];
    [self.driver.loaderManager.decoderManager unregisterAllDecoder];
}

- (LKImageManager *)driver {
    return LKImageManager.defaultManager;
}

#pragma mark -
#pragma mark Core Methods
- (void)sendRequest:(id<ImageRequest>)request
 withProgressNotify:(ImageLoadProgressCallback _Nullable)onProgress
      andCompletion:(ImageLoadingCompletion)completion {
    if (![request isKindOfClass:LKImageRequestBridge.class]) {
        TIError *error = [TIError errorWithCode:ResultCodeUnderlayerDriverMismatch];
        TIExecBlockOnMainQueue(completion, request, nil, error, false);
        return;
    }
    
    LKImageRequestBridge *lkRequest = (LKImageRequestBridge *)request;
    
    [self.driver sendRequest:lkRequest.driver completion:^(LKImageRequest *request, UIImage *image, BOOL isCache) {
        id<ImageRequest> currentRequest = [[LKImageRequestBridge alloc] initWithLKRequest:request];
        if (request.state == LKImageRequestStateLoading) {
            TIExecBlockOnMainQueue(onProgress, currentRequest);
            return;
        }

        TIExecBlockOnMainQueue(completion, currentRequest, image, request.error, isCache || request.hasCache);
    }];
}

- (void)cancelRequest:(id<ImageRequest>)request {
    if (![request isKindOfClass:LKImageRequestBridge.class]) {
        return;
    }
    
    LKImageRequestBridge *lkRequest = (LKImageRequestBridge *)request;
    [self.driver cancelRequest:lkRequest.driver];
}

#pragma mark -
#pragma mark Setters & Getters
- (void)setMaxConcurrentCount:(NSInteger)maxConcurrentCount {
    _networkLoader.maxConcurrentOperationCount = maxConcurrentCount;
}

- (NSInteger)maxConcurrentCount {
    return _networkLoader.maxConcurrentOperationCount;
}

- (void)setTimeoutInterval:(NSInteger)timeoutInterval {
    _networkLoader.timeoutInterval = timeoutInterval;
}

- (NSInteger)timeoutInterval {
    return _networkLoader.timeoutInterval;
}

- (void)setMaxCacheSize:(NSInteger)maxCacheSize {
    _memoryCache.cacheSizeLimit = maxCacheSize;
}

- (NSInteger)maxCacheSize {
    return _memoryCache.cacheSizeLimit;
}

- (void)setRetryCount:(NSInteger)retryCount {
    _networkLoader.retryTimes = retryCount;
}

- (NSInteger)retryCount {
    return _networkLoader.retryTimes;
}

@end
