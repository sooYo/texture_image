///
//  Generated code. Do not modify.
//  source: image_utils.proto
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
  ],
};

/// Descriptor for `BoxFit`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List boxFitDescriptor = $convert.base64Decode('CgZCb3hGaXQSCAoEZmlsbBAAEgsKB2NvbnRhaW4QARIJCgVjb3ZlchACEgwKCGZpdFdpZHRoEAMSDQoJZml0SGVpZ2h0EAQ=');
@$core.Deprecated('Use taskStateDescriptor instead')
const TaskState$json = const {
  '1': 'TaskState',
  '2': const [
    const {'1': 'initialized', '2': 0},
    const {'1': 'loading', '2': 1},
    const {'1': 'completed', '2': 2},
    const {'1': 'failed', '2': 3},
    const {'1': 'disposed', '2': 4},
    const {'1': 'undefined', '2': 5},
  ],
};

/// Descriptor for `TaskState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List taskStateDescriptor = $convert.base64Decode('CglUYXNrU3RhdGUSDwoLaW5pdGlhbGl6ZWQQABILCgdsb2FkaW5nEAESDQoJY29tcGxldGVkEAISCgoGZmFpbGVkEAMSDAoIZGlzcG9zZWQQBBINCgl1bmRlZmluZWQQBQ==');
@$core.Deprecated('Use borderRadiusDescriptor instead')
const BorderRadius$json = const {
  '1': 'BorderRadius',
  '2': const [
    const {'1': 'topLeft', '3': 1, '4': 1, '5': 1, '10': 'topLeft'},
    const {'1': 'topRight', '3': 2, '4': 1, '5': 1, '10': 'topRight'},
    const {'1': 'bottomLeft', '3': 3, '4': 1, '5': 1, '10': 'bottomLeft'},
    const {'1': 'bottomRight', '3': 4, '4': 1, '5': 1, '10': 'bottomRight'},
  ],
};

/// Descriptor for `BorderRadius`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List borderRadiusDescriptor = $convert.base64Decode('CgxCb3JkZXJSYWRpdXMSGAoHdG9wTGVmdBgBIAEoAVIHdG9wTGVmdBIaCgh0b3BSaWdodBgCIAEoAVIIdG9wUmlnaHQSHgoKYm90dG9tTGVmdBgDIAEoAVIKYm90dG9tTGVmdBIgCgtib3R0b21SaWdodBgEIAEoAVILYm90dG9tUmlnaHQ=');
@$core.Deprecated('Use geometryDescriptor instead')
const Geometry$json = const {
  '1': 'Geometry',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 5, '10': 'height'},
    const {'1': 'fit', '3': 3, '4': 1, '5': 14, '6': '.BoxFit', '10': 'fit'},
    const {'1': 'borderRadius', '3': 4, '4': 1, '5': 11, '6': '.BorderRadius', '10': 'borderRadius'},
  ],
};

/// Descriptor for `Geometry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List geometryDescriptor = $convert.base64Decode('CghHZW9tZXRyeRIUCgV3aWR0aBgBIAEoBVIFd2lkdGgSFgoGaGVpZ2h0GAIgASgFUgZoZWlnaHQSGQoDZml0GAMgASgOMgcuQm94Rml0UgNmaXQSMQoMYm9yZGVyUmFkaXVzGAQgASgLMg0uQm9yZGVyUmFkaXVzUgxib3JkZXJSYWRpdXM=');
