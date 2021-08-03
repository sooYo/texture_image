///
//  Generated code. Do not modify.
//  source: image_utils.proto
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

  static const $core.List<BoxFit> values = <BoxFit> [
    fill,
    contain,
    cover,
    fitWidth,
    fitHeight,
  ];

  static final $core.Map<$core.int, BoxFit> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BoxFit? valueOf($core.int value) => _byValue[value];

  const BoxFit._($core.int v, $core.String n) : super(v, n);
}

class TaskState extends $pb.ProtobufEnum {
  static const TaskState initialized = TaskState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'initialized');
  static const TaskState loading = TaskState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'loading');
  static const TaskState completed = TaskState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'completed');
  static const TaskState failed = TaskState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'failed');
  static const TaskState disposed = TaskState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'disposed');
  static const TaskState undefined = TaskState._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'undefined');

  static const $core.List<TaskState> values = <TaskState> [
    initialized,
    loading,
    completed,
    failed,
    disposed,
    undefined,
  ];

  static final $core.Map<$core.int, TaskState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TaskState? valueOf($core.int value) => _byValue[value];

  const TaskState._($core.int v, $core.String n) : super(v, n);
}

