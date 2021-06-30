///
//  Generated code. Do not modify.
//  source: method_call_result.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use imageTaskStateDescriptor instead')
const ImageTaskState$json = const {
  '1': 'ImageTaskState',
  '2': const [
    const {'1': 'initialized', '2': 0},
    const {'1': 'loading', '2': 1},
    const {'1': 'completed', '2': 2},
    const {'1': 'canceled', '2': 3},
    const {'1': 'failed', '2': 4},
  ],
};

/// Descriptor for `ImageTaskState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List imageTaskStateDescriptor = $convert.base64Decode('Cg5JbWFnZVRhc2tTdGF0ZRIPCgtpbml0aWFsaXplZBAAEgsKB2xvYWRpbmcQARINCgljb21wbGV0ZWQQAhIMCghjYW5jZWxlZBADEgoKBmZhaWxlZBAE');
@$core.Deprecated('Use imageResultDescriptor instead')
const ImageResult$json = const {
  '1': 'ImageResult',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'textureId', '3': 3, '4': 1, '5': 5, '10': 'textureId'},
    const {'1': 'state', '3': 4, '4': 1, '5': 14, '6': '.ImageTaskState', '10': 'state'},
    const {'1': 'url', '3': 5, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `ImageResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageResultDescriptor = $convert.base64Decode('CgtJbWFnZVJlc3VsdBISCgRjb2RlGAEgASgFUgRjb2RlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USHAoJdGV4dHVyZUlkGAMgASgFUgl0ZXh0dXJlSWQSJQoFc3RhdGUYBCABKA4yDy5JbWFnZVRhc2tTdGF0ZVIFc3RhdGUSEAoDdXJsGAUgASgJUgN1cmw=');
