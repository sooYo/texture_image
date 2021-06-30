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
#import "BorderRadius.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(ImageBorderRadius);

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

#pragma mark - TextureImageInfo

@implementation TextureImageInfo

@dynamic URL;
@dynamic width;
@dynamic height;
@dynamic errorPlaceholder;
@dynamic placeholder;
@dynamic hasBorderRadius, borderRadius;

typedef struct TextureImageInfo__storage_ {
  uint32_t _has_storage_[1];
  int32_t width;
  int32_t height;
  NSString *URL;
  NSString *errorPlaceholder;
  NSString *placeholder;
  ImageBorderRadius *borderRadius;
} TextureImageInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "URL",
        .dataTypeSpecific.clazz = Nil,
        .number = TextureImageInfo_FieldNumber_URL,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TextureImageInfo__storage_, URL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "width",
        .dataTypeSpecific.clazz = Nil,
        .number = TextureImageInfo_FieldNumber_Width,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TextureImageInfo__storage_, width),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "height",
        .dataTypeSpecific.clazz = Nil,
        .number = TextureImageInfo_FieldNumber_Height,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(TextureImageInfo__storage_, height),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "errorPlaceholder",
        .dataTypeSpecific.clazz = Nil,
        .number = TextureImageInfo_FieldNumber_ErrorPlaceholder,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(TextureImageInfo__storage_, errorPlaceholder),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "placeholder",
        .dataTypeSpecific.clazz = Nil,
        .number = TextureImageInfo_FieldNumber_Placeholder,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(TextureImageInfo__storage_, placeholder),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "borderRadius",
        .dataTypeSpecific.clazz = GPBObjCClass(ImageBorderRadius),
        .number = TextureImageInfo_FieldNumber_BorderRadius,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(TextureImageInfo__storage_, borderRadius),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TextureImageInfo class]
                                     rootClass:[ImageInfoRoot class]
                                          file:ImageInfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TextureImageInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\003\001!!!\000\004\020\000\006\014\000";
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
