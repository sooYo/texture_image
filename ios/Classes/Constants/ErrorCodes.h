/// Error code list
///
/// This file is generated by shell script on 2021-09-18, please don't edit this file manually

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ErrorCode) {
    // Success
    OK = 200,
    
    // Cannot parse PB data
    pbParseFailed = 100001,
    
    // Arguments from channel method params map with a wrong data type
    argumentTypeError = 100002,
    
    // The task has been reused and previous loading mission should be cancelled
    taskHasBeenReused = 100003,
    
    // Image widget has been disposed before it's attached fetching task completed
    disposedBeforeHttpResponses = 100004,
    
};