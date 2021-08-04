// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: image_info.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import "ImageInfo.pbobjc.h"
#import "ImageUtils.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(Geometry);

#pragma mark - ImageInfoRoot

@implementation ImageInfoRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - ImageInfoRoot_FileDescriptor

static GPBFileDescriptor *ImageInfoRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@""
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - ImageFetchInfo

@implementation ImageFetchInfo

@dynamic URL;
@dynamic errorPlaceholder;
@dynamic placeholder;
@dynamic hasGeometry, geometry;

typedef struct ImageFetchInfo__storage_ {
  uint32_t _has_storage_[1];
  NSString *URL;
  NSString *errorPlaceholder;
  NSString *placeholder;
  Geometry *geometry;
} ImageFetchInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "URL",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageFetchInfo_FieldNumber_URL,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ImageFetchInfo__storage_, URL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "errorPlaceholder",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageFetchInfo_FieldNumber_ErrorPlaceholder,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ImageFetchInfo__storage_, errorPlaceholder),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "placeholder",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageFetchInfo_FieldNumber_Placeholder,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(ImageFetchInfo__storage_, placeholder),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "geometry",
        .dataTypeSpecific.clazz = GPBObjCClass(Geometry),
        .number = ImageFetchInfo_FieldNumber_Geometry,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(ImageFetchInfo__storage_, geometry),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ImageFetchInfo class]
                                     rootClass:[ImageInfoRoot class]
                                          file:ImageInfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ImageFetchInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\001!!!\000\002\020\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - ResultInfo

@implementation ResultInfo

@dynamic code;
@dynamic message;

typedef struct ResultInfo__storage_ {
  uint32_t _has_storage_[1];
  int32_t code;
  NSString *message;
} ResultInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "code",
        .dataTypeSpecific.clazz = Nil,
        .number = ResultInfo_FieldNumber_Code,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ResultInfo__storage_, code),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "message",
        .dataTypeSpecific.clazz = Nil,
        .number = ResultInfo_FieldNumber_Message,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ResultInfo__storage_, message),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ResultInfo class]
                                     rootClass:[ImageInfoRoot class]
                                          file:ImageInfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ResultInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - ImageFetchResultInfo

@implementation ImageFetchResultInfo

@dynamic code;
@dynamic textureId;
@dynamic message;
@dynamic URL;
@dynamic state;

typedef struct ImageFetchResultInfo__storage_ {
  uint32_t _has_storage_[1];
  int32_t code;
  TaskState state;
  NSString *message;
  NSString *URL;
  int64_t textureId;
} ImageFetchResultInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "code",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageFetchResultInfo_FieldNumber_Code,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ImageFetchResultInfo__storage_, code),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "textureId",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageFetchResultInfo_FieldNumber_TextureId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ImageFetchResultInfo__storage_, textureId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "message",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageFetchResultInfo_FieldNumber_Message,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(ImageFetchResultInfo__storage_, message),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "URL",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageFetchResultInfo_FieldNumber_URL,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(ImageFetchResultInfo__storage_, URL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "state",
        .dataTypeSpecific.enumDescFunc = TaskState_EnumDescriptor,
        .number = ImageFetchResultInfo_FieldNumber_State,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(ImageFetchResultInfo__storage_, state),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ImageFetchResultInfo class]
                                     rootClass:[ImageInfoRoot class]
                                          file:ImageInfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ImageFetchResultInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\002\t\000\004!!!\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t ImageFetchResultInfo_State_RawValue(ImageFetchResultInfo *message) {
  GPBDescriptor *descriptor = [ImageFetchResultInfo descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:ImageFetchResultInfo_FieldNumber_State];
  return GPBGetMessageRawEnumField(message, field);
}

void SetImageFetchResultInfo_State_RawValue(ImageFetchResultInfo *message, int32_t value) {
  GPBDescriptor *descriptor = [ImageFetchResultInfo descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:ImageFetchResultInfo_FieldNumber_State];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - ImageDisposeInfo

@implementation ImageDisposeInfo

@dynamic URL;
@dynamic textureId;

typedef struct ImageDisposeInfo__storage_ {
  uint32_t _has_storage_[1];
  NSString *URL;
  int64_t textureId;
} ImageDisposeInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "URL",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageDisposeInfo_FieldNumber_URL,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ImageDisposeInfo__storage_, URL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "textureId",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageDisposeInfo_FieldNumber_TextureId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ImageDisposeInfo__storage_, textureId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ImageDisposeInfo class]
                                     rootClass:[ImageInfoRoot class]
                                          file:ImageInfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ImageDisposeInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\001!!!\000\002\t\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - ImageConfigInfo

@implementation ImageConfigInfo

@dynamic placeholder;
@dynamic errorPlaceholder;
@dynamic backgroundColor;
@dynamic androidAvailableMemoryPercentage;

typedef struct ImageConfigInfo__storage_ {
  uint32_t _has_storage_[1];
  NSString *placeholder;
  NSString *errorPlaceholder;
  NSString *backgroundColor;
  double androidAvailableMemoryPercentage;
} ImageConfigInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "placeholder",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageConfigInfo_FieldNumber_Placeholder,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ImageConfigInfo__storage_, placeholder),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "errorPlaceholder",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageConfigInfo_FieldNumber_ErrorPlaceholder,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ImageConfigInfo__storage_, errorPlaceholder),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "backgroundColor",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageConfigInfo_FieldNumber_BackgroundColor,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(ImageConfigInfo__storage_, backgroundColor),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "androidAvailableMemoryPercentage",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageConfigInfo_FieldNumber_AndroidAvailableMemoryPercentage,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(ImageConfigInfo__storage_, androidAvailableMemoryPercentage),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeDouble,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ImageConfigInfo class]
                                     rootClass:[ImageInfoRoot class]
                                          file:ImageInfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ImageConfigInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\003\002\020\000\003\017\000\004\037\001\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
