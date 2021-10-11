//
//  ImageLoadState.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/9.
//

#ifndef ImageLoadState_h
#define ImageLoadState_h

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, ImageLoadState) {
    initailized,
    loading,
    canceled,
    success,
    failed,
}

#endif /* ImageLoadState_h */
