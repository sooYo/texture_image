//
//  Codes.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/11.
//

#ifndef Codes_h
#define Codes_h

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, ResultCode) {
    ResultCodeOK = 200,
    ResultCodeUnknown = -1,
    ResultCodeCanceled = -100,
    
    ResultCodeProcessFailed = 100001, // Processor cann't handle the image
};

#endif
