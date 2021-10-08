/// Error code list
///
/// This file is generated by shell script on 2021-10-08, please don't edit this file manually

class ErrorCode {
  // Success
  static const OK = 200;
  
  // Cannot parse PB data
  static const pbParseFailed = 100001;
  
  // Arguments from channel method params map with a wrong data type
  static const argumentTypeError = 100002;
  
  // The task has been reused and previous loading mission should be cancelled
  static const taskHasBeenReused = 100003;
  
  // Image widget has been disposed before its attached fetching task completed
  static const disposedBeforeHttpResponses = 100004;
  
}