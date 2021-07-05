///
//  Generated code. Do not modify.
//  source: enum.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use boxFitDescriptor instead')
const BoxFit$json = const {
  '1': 'BoxFit',
  '2': const [
    const {'1': 'fill', '2': 0},
    const {'1': 'contain', '2': 1},
    const {'1': 'cover', '2': 2},
    const {'1': 'fitWidth', '2': 3},
    const {'1': 'fitHeight', '2': 4},
    const {'1': 'none', '2': 5},
  ],
};

/// Descriptor for `BoxFit`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List boxFitDescriptor = $convert.base64Decode('CgZCb3hGaXQSCAoEZmlsbBAAEgsKB2NvbnRhaW4QARIJCgVjb3ZlchACEgwKCGZpdFdpZHRoEAMSDQoJZml0SGVpZ2h0EAQSCAoEbm9uZRAF');
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
