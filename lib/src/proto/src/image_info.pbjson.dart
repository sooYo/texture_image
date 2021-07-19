///
//  Generated code. Do not modify.
//  source: image_info.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use imageFetchInfoDescriptor instead')
const ImageFetchInfo$json = const {
  '1': 'ImageFetchInfo',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'errorPlaceholder', '3': 2, '4': 1, '5': 9, '10': 'errorPlaceholder'},
    const {'1': 'placeholder', '3': 3, '4': 1, '5': 9, '10': 'placeholder'},
    const {'1': 'geometry', '3': 4, '4': 1, '5': 11, '6': '.Geometry', '10': 'geometry'},
  ],
};

/// Descriptor for `ImageFetchInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageFetchInfoDescriptor = $convert.base64Decode('Cg5JbWFnZUZldGNoSW5mbxIQCgN1cmwYASABKAlSA3VybBIqChBlcnJvclBsYWNlaG9sZGVyGAIgASgJUhBlcnJvclBsYWNlaG9sZGVyEiAKC3BsYWNlaG9sZGVyGAMgASgJUgtwbGFjZWhvbGRlchIlCghnZW9tZXRyeRgEIAEoCzIJLkdlb21ldHJ5UghnZW9tZXRyeQ==');
@$core.Deprecated('Use imageFetchResultInfoDescriptor instead')
const ImageFetchResultInfo$json = const {
  '1': 'ImageFetchResultInfo',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    const {'1': 'textureId', '3': 2, '4': 1, '5': 3, '10': 'textureId'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'state', '3': 5, '4': 1, '5': 14, '6': '.TaskState', '10': 'state'},
  ],
};

/// Descriptor for `ImageFetchResultInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageFetchResultInfoDescriptor = $convert.base64Decode('ChRJbWFnZUZldGNoUmVzdWx0SW5mbxISCgRjb2RlGAEgASgFUgRjb2RlEhwKCXRleHR1cmVJZBgCIAEoA1IJdGV4dHVyZUlkEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USEAoDdXJsGAQgASgJUgN1cmwSIAoFc3RhdGUYBSABKA4yCi5UYXNrU3RhdGVSBXN0YXRl');
@$core.Deprecated('Use imageFetchCancelInfoDescriptor instead')
const ImageFetchCancelInfo$json = const {
  '1': 'ImageFetchCancelInfo',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'textureId', '3': 2, '4': 1, '5': 3, '10': 'textureId'},
  ],
};

/// Descriptor for `ImageFetchCancelInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageFetchCancelInfoDescriptor = $convert.base64Decode('ChRJbWFnZUZldGNoQ2FuY2VsSW5mbxIQCgN1cmwYASABKAlSA3VybBIcCgl0ZXh0dXJlSWQYAiABKANSCXRleHR1cmVJZA==');
