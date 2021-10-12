#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

#import "LKImageLoaderBridge.h"
#import "LKImageRequestBridge.h"
#import "Utils.h"

@interface AppDelegate ()

@property (nonatomic, strong) id<ImageLoader> loader;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    
    _loader = [[LKImageLoaderBridge alloc] init];
    _loader.retryCount = 2;
    
    id<ImageRequest> request = [[LKImageRequestBridge alloc] initWithURL:@"http://y0.ifengimg.com/25377ec733ae1ea0/2015/1105/rdn_563b1b0f529a6.jpg"];
    request.cacheEnable = true;
    request.preferedSize = CGSizeMake(300, 300);
    
    [_loader sendRequest:request withProgressNotify:^(id<ImageRequest> request) {
        NSLog(@"On progress: %f", request.progress);
    } andCompletion:^(id<ImageRequest> request, UIImage * image, NSError * error, BOOL isFromCache) {
        NSLog(@"error: %@", error);
        NSLog(@"image: %@", image);
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_loader cancelRequest:request];
//    });
    
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
