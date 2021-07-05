///
//  Generated code. Do not modify.
//  source: image_info.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use imageRequestInfoDescriptor instead')
const ImageRequestInfo$json = const {
  '1': 'ImageRequestInfo',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'width', '3': 2, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 3, '4': 1, '5': 5, '10': 'height'},
    const {'1': 'errorPlaceholder', '3': 4, '4': 1, '5': 9, '10': 'errorPlaceholder'},
    const {'1': 'placeholder', '3': 5, '4': 1, '5': 9, '10': 'placeholder'},
    const {'1': 'fit', '3': 6, '4': 1, '5': 14, '6': '.BoxFit', '10': 'fit'},
    const {'1': 'borderRadius', '3': 7, '4': 1, '5': 11, '6': '.ImageBorderRadius', '10': 'borderRadius'},
  ],
};

/// Descriptor for `ImageRequestInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageRequestInfoDescriptor = $convert.base64Decode('ChBJbWFnZVJlcXVlc3RJbmZvEhAKA3VybBgBIAEoCVIDdXJsEhQKBXdpZHRoGAIgASgFUgV3aWR0aBIWCgZoZWlnaHQYAyABKAVSBmhlaWdodBIqChBlcnJvclBsYWNlaG9sZGVyGAQgASgJUhBlcnJvclBsYWNlaG9sZGVyEiAKC3BsYWNlaG9sZGVyGAUgASgJUgtwbGFjZWhvbGRlchIZCgNmaXQYBiABKA4yBy5Cb3hGaXRSA2ZpdBI2Cgxib3JkZXJSYWRpdXMYByABKAsyEi5JbWFnZUJvcmRlclJhZGl1c1IMYm9yZGVyUmFkaXVz');
@$core.Deprecated('Use imageRequestCancelInfoDescriptor instead')
const ImageRequestCancelInfo$json = const {
  '1': 'ImageRequestCancelInfo',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'textureId', '3': 2, '4': 1, '5': 3, '10': 'textureId'},
  ],
};

/// Descriptor for `ImageRequestCancelInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageRequestCancelInfoDescriptor = $convert.base64Decode('ChZJbWFnZVJlcXVlc3RDYW5jZWxJbmZvEhAKA3VybBgBIAEoCVIDdXJsEhwKCXRleHR1cmVJZBgCIAEoA1IJdGV4dHVyZUlk');
@$core.Deprecated('Use imageBorderRadiusDescriptor instead')
const ImageBorderRadius$json = const {
  '1': 'ImageBorderRadius',
  '2': const [
    const {'1': 'topLeft', '3': 1, '4': 1, '5': 1, '10': 'topLeft'},
    const {'1': 'topRight', '3': 2, '4': 1, '5': 1, '10': 'topRight'},
    const {'1': 'bottomLeft', '3': 3, '4': 1, '5': 1, '10': 'bottomLeft'},
    const {'1': 'bottomRight', '3': 4, '4': 1, '5': 1, '10': 'bottomRight'},
  ],
};

/// Descriptor for `ImageBorderRadius`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageBorderRadiusDescriptor = $convert.base64Decode('ChFJbWFnZUJvcmRlclJhZGl1cxIYCgd0b3BMZWZ0GAEgASgBUgd0b3BMZWZ0EhoKCHRvcFJpZ2h0GAIgASgBUgh0b3BSaWdodBIeCgpib3R0b21MZWZ0GAMgASgBUgpib3R0b21MZWZ0EiAKC2JvdHRvbVJpZ2h0GAQgASgBUgtib3R0b21SaWdodA==');
