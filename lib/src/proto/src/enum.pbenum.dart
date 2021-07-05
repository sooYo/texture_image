///
//  Generated code. Do not modify.
//  source: enum.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class BoxFit extends $pb.ProtobufEnum {
  static const BoxFit fill = BoxFit._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'fill');
  static const BoxFit contain = BoxFit._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'contain');
  static const BoxFit cover = BoxFit._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'cover');
  static const BoxFit fitWidth = BoxFit._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'fitWidth');
  static const BoxFit fitHeight = BoxFit._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'fitHeight');
  static const BoxFit none = BoxFit._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'none');

  static const $core.List<BoxFit> values = <BoxFit> [
    fill,
    contain,
    cover,
    fitWidth,
    fitHeight,
    none,
  ];

  static final $core.Map<$core.int, BoxFit> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BoxFit? valueOf($core.int value) => _byValue[value];

  const BoxFit._($core.int v, $core.String n) : super(v, n);
}

class ImageTaskState extends $pb.ProtobufEnum {
  static const ImageTaskState initialized = ImageTaskState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'initialized');
  static const ImageTaskState loading = ImageTaskState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'loading');
  static const ImageTaskState completed = ImageTaskState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'completed');
  static const ImageTaskState canceled = ImageTaskState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'canceled');
  static const ImageTaskState failed = ImageTaskState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'failed');

  static const $core.List<ImageTaskState> values = <ImageTaskState> [
    initialized,
    loading,
    completed,
    canceled,
    failed,
  ];

  static final $core.Map<$core.int, ImageTaskState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ImageTaskState? valueOf($core.int value) => _byValue[value];

  const ImageTaskState._($core.int v, $core.String n) : super(v, n);
}

