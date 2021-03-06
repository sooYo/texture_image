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
    const {'1': 'grayScale', '3': 4, '4': 1, '5': 8, '10': 'grayScale'},
    const {'1': 'blur', '3': 5, '4': 1, '5': 5, '10': 'blur'},
    const {'1': 'blurSampling', '3': 6, '4': 1, '5': 2, '10': 'blurSampling'},
    const {'1': 'geometry', '3': 7, '4': 1, '5': 11, '6': '.Geometry', '10': 'geometry'},
    const {'1': 'quality', '3': 8, '4': 1, '5': 11, '6': '.Quality', '10': 'quality'},
  ],
};

/// Descriptor for `ImageFetchInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageFetchInfoDescriptor = $convert.base64Decode('Cg5JbWFnZUZldGNoSW5mbxIQCgN1cmwYASABKAlSA3VybBIqChBlcnJvclBsYWNlaG9sZGVyGAIgASgJUhBlcnJvclBsYWNlaG9sZGVyEiAKC3BsYWNlaG9sZGVyGAMgASgJUgtwbGFjZWhvbGRlchIcCglncmF5U2NhbGUYBCABKAhSCWdyYXlTY2FsZRISCgRibHVyGAUgASgFUgRibHVyEiIKDGJsdXJTYW1wbGluZxgGIAEoAlIMYmx1clNhbXBsaW5nEiUKCGdlb21ldHJ5GAcgASgLMgkuR2VvbWV0cnlSCGdlb21ldHJ5EiIKB3F1YWxpdHkYCCABKAsyCC5RdWFsaXR5UgdxdWFsaXR5');
@$core.Deprecated('Use imageDisposeInfoDescriptor instead')
const ImageDisposeInfo$json = const {
  '1': 'ImageDisposeInfo',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'textureId', '3': 2, '4': 1, '5': 3, '10': 'textureId'},
    const {'1': 'canBeReused', '3': 3, '4': 1, '5': 8, '10': 'canBeReused'},
  ],
};

/// Descriptor for `ImageDisposeInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageDisposeInfoDescriptor = $convert.base64Decode('ChBJbWFnZURpc3Bvc2VJbmZvEhAKA3VybBgBIAEoCVIDdXJsEhwKCXRleHR1cmVJZBgCIAEoA1IJdGV4dHVyZUlkEiAKC2NhbkJlUmV1c2VkGAMgASgIUgtjYW5CZVJldXNlZA==');
@$core.Deprecated('Use imageConfigInfoDescriptor instead')
const ImageConfigInfo$json = const {
  '1': 'ImageConfigInfo',
  '2': const [
    const {'1': 'placeholder', '3': 1, '4': 1, '5': 9, '10': 'placeholder'},
    const {'1': 'errorPlaceholder', '3': 2, '4': 1, '5': 9, '10': 'errorPlaceholder'},
    const {'1': 'backgroundColor', '3': 3, '4': 1, '5': 9, '10': 'backgroundColor'},
    const {'1': 'androidAvailableMemoryPercentage', '3': 4, '4': 1, '5': 1, '10': 'androidAvailableMemoryPercentage'},
    const {'1': 'reduceQualityInLowMemory', '3': 5, '4': 1, '5': 8, '10': 'reduceQualityInLowMemory'},
    const {'1': 'useOpenGLRendering', '3': 6, '4': 1, '5': 8, '10': 'useOpenGLRendering'},
  ],
};

/// Descriptor for `ImageConfigInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageConfigInfoDescriptor = $convert.base64Decode('Cg9JbWFnZUNvbmZpZ0luZm8SIAoLcGxhY2Vob2xkZXIYASABKAlSC3BsYWNlaG9sZGVyEioKEGVycm9yUGxhY2Vob2xkZXIYAiABKAlSEGVycm9yUGxhY2Vob2xkZXISKAoPYmFja2dyb3VuZENvbG9yGAMgASgJUg9iYWNrZ3JvdW5kQ29sb3ISSgogYW5kcm9pZEF2YWlsYWJsZU1lbW9yeVBlcmNlbnRhZ2UYBCABKAFSIGFuZHJvaWRBdmFpbGFibGVNZW1vcnlQZXJjZW50YWdlEjoKGHJlZHVjZVF1YWxpdHlJbkxvd01lbW9yeRgFIAEoCFIYcmVkdWNlUXVhbGl0eUluTG93TWVtb3J5Ei4KEnVzZU9wZW5HTFJlbmRlcmluZxgGIAEoCFISdXNlT3BlbkdMUmVuZGVyaW5n');
@$core.Deprecated('Use resultInfoDescriptor instead')
const ResultInfo$json = const {
  '1': 'ResultInfo',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    const {'1': 'textureId', '3': 2, '4': 1, '5': 3, '10': 'textureId'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'state', '3': 5, '4': 1, '5': 14, '6': '.TaskState', '10': 'state'},
  ],
};

/// Descriptor for `ResultInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultInfoDescriptor = $convert.base64Decode('CgpSZXN1bHRJbmZvEhIKBGNvZGUYASABKAVSBGNvZGUSHAoJdGV4dHVyZUlkGAIgASgDUgl0ZXh0dXJlSWQSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIQCgN1cmwYBCABKAlSA3VybBIgCgVzdGF0ZRgFIAEoDjIKLlRhc2tTdGF0ZVIFc3RhdGU=');
