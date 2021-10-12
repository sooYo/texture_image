//
//  ImageGrayScaleProcessor.m
//  TextureImage
//
//  Created by Sooyo on 2021/10/11.
//

#import "ImageGrayScaleProcessor.h"
#import "ImageRequest.h"

#import "TIError.h"
#import "Macros.h"

@implementation ImageGrayScaleProcessor

@dynamic identifier;

- (NSString *)identifier {
    return NSStringFromClass(self.class);
}

- (void)processImage:(UIImage *)image request:(id<ImageRequest>)request withCompletion:(ImageProcessCompletion)completion {
    if (dispatch_queue_get_label(dispatch_get_main_queue()))
    @autoreleasepool {
        size_t width = image.size.width * image.scale;
        size_t height = image.size.height * image.scale;
        
        // Use gray color space to redraw the target image
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGBitmapByteOrderDefault);
        
        CGColorSpaceRelease(colorSpace);

        if (context == NULL) {
            TIExecBlock(completion, nil, [TIError processorErrorForType:self.identifier url:request.url]);
            return;
        }
        
        // Redraw target image
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
        
        // Turn into UIImage
        CGImageRef cgImage = CGBitmapContextCreateImage(context);
        UIImage *result = [UIImage imageWithCGImage:cgImage scale:image.scale orientation:image.imageOrientation];
    
        CGImageRelease(cgImage);
        CGContextRelease(context);
        
        TIExecBlock(completion, result, nil);
    }
}

@end
