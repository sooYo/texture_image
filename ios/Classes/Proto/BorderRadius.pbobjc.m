// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: border_radius.proto

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

#import "BorderRadius.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - BorderRadiusRoot

@implementation BorderRadiusRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - BorderRadiusRoot_FileDescriptor

static GPBFileDescriptor *BorderRadiusRoot_FileDescriptor(void) {
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

#pragma mark - ImageBorderRadius

@implementation ImageBorderRadius

@dynamic topLeft;
@dynamic topRight;
@dynamic bottomLeft;
@dynamic bottomRight;

typedef struct ImageBorderRadius__storage_ {
  uint32_t _has_storage_[1];
  float topLeft;
  float topRight;
  float bottomLeft;
  float bottomRight;
} ImageBorderRadius__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "topLeft",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageBorderRadius_FieldNumber_TopLeft,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ImageBorderRadius__storage_, topLeft),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "topRight",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageBorderRadius_FieldNumber_TopRight,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ImageBorderRadius__storage_, topRight),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "bottomLeft",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageBorderRadius_FieldNumber_BottomLeft,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(ImageBorderRadius__storage_, bottomLeft),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "bottomRight",
        .dataTypeSpecific.clazz = Nil,
        .number = ImageBorderRadius_FieldNumber_BottomRight,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(ImageBorderRadius__storage_, bottomRight),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeFloat,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ImageBorderRadius class]
                                     rootClass:[BorderRadiusRoot class]
                                          file:BorderRadiusRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ImageBorderRadius__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\004\001\007\000\002\010\000\003\n\000\004\013\000";
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
