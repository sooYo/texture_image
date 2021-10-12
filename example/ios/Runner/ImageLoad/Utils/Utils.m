//
//  Utils.m
//  TextureImage
//
//  Created by Sooyo on 2021/10/12.
//

#import "Utils.h"

@implementation Utils

+ (BOOL)isOnMainQueue {
    const char *queueLabel = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
    const char *mainQueueLabel = dispatch_queue_get_label(dispatch_get_main_queue());
    return strcmp(queueLabel, mainQueueLabel) == 0;
}

@end
