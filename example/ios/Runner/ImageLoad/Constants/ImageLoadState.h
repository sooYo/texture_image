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
    ImageLoadStateInitailized,
    ImageLoadStateLoading,
    ImageLoadStateCanceled,
    ImageLoadStateSuccess,
    ImageLoadStateFailed,
};

#endif /* ImageLoadState_h */
