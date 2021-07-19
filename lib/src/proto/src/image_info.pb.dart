///
//  Generated code. Do not modify.
//  source: image_info.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'image_utils.pb.dart' as $0;

import 'image_utils.pbenum.dart' as $0;

class ImageFetchInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageFetchInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorPlaceholder', protoName: 'errorPlaceholder')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder')
    ..aOM<$0.Geometry>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'geometry', subBuilder: $0.Geometry.create)
    ..hasRequiredFields = false
  ;

  ImageFetchInfo._() : super();
  factory ImageFetchInfo({
    $core.String? url,
    $core.String? errorPlaceholder,
    $core.String? placeholder,
    $0.Geometry? geometry,
  }) {
    final _result = create();
    if (url != null) {
      _result.url = url;
    }
    if (errorPlaceholder != null) {
      _result.errorPlaceholder = errorPlaceholder;
    }
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (geometry != null) {
      _result.geometry = geometry;
    }
    return _result;
  }
  factory ImageFetchInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageFetchInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageFetchInfo clone() => ImageFetchInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageFetchInfo copyWith(void Function(ImageFetchInfo) updates) => super.copyWith((message) => updates(message as ImageFetchInfo)) as ImageFetchInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageFetchInfo create() => ImageFetchInfo._();
  ImageFetchInfo createEmptyInstance() => create();
  static $pb.PbList<ImageFetchInfo> createRepeated() => $pb.PbList<ImageFetchInfo>();
  @$core.pragma('dart2js:noInline')
  static ImageFetchInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageFetchInfo>(create);
  static ImageFetchInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorPlaceholder => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorPlaceholder($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorPlaceholder() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorPlaceholder() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get placeholder => $_getSZ(2);
  @$pb.TagNumber(3)
  set placeholder($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPlaceholder() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlaceholder() => clearField(3);

  @$pb.TagNumber(4)
  $0.Geometry get geometry => $_getN(3);
  @$pb.TagNumber(4)
  set geometry($0.Geometry v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGeometry() => $_has(3);
  @$pb.TagNumber(4)
  void clearGeometry() => clearField(4);
  @$pb.TagNumber(4)
  $0.Geometry ensureGeometry() => $_ensure(3);
}

class ImageFetchResultInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageFetchResultInfo', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.O3)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'textureId', protoName: 'textureId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..e<$0.TaskState>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: $0.TaskState.initialized, valueOf: $0.TaskState.valueOf, enumValues: $0.TaskState.values)
    ..hasRequiredFields = false
  ;

  ImageFetchResultInfo._() : super();
  factory ImageFetchResultInfo({
    $core.int? code,
    $fixnum.Int64? textureId,
    $core.String? message,
    $core.String? url,
    $0.TaskState? state,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (textureId != null) {
      _result.textureId = textureId;
    }
    if (message != null) {
      _result.message = message;
    }
    if (url != null) {
      _result.url = url;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory ImageFetchResultInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageFetchResultInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageFetchResultInfo clone() => ImageFetchResultInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageFetchResultInfo copyWith(void Function(ImageFetchResultInfo) updates) => super.copyWith((message) => updates(message as ImageFetchResultInfo)) as ImageFetchResultInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageFetchResultInfo create() => ImageFetchResultInfo._();
  ImageFetchResultInfo createEmptyInstance() => create();
  static $pb.PbList<ImageFetchResultInfo> createRepeated() => $pb.PbList<ImageFetchResultInfo>();
  @$core.pragma('dart2js:noInline')
  static ImageFetchResultInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageFetchResultInfo>(create);
  static ImageFetchResultInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get textureId => $_getI64(1);
  @$pb.TagNumber(2)
  set textureId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTextureId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTextureId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => clearField(4);

  @$pb.TagNumber(5)
  $0.TaskState get state => $_getN(4);
  @$pb.TagNumber(5)
  set state($0.TaskState v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasState() => $_has(4);
  @$pb.TagNumber(5)
  void clearState() => clearField(5);
}

class ImageFetchCancelInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageFetchCancelInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'textureId', protoName: 'textureId')
    ..hasRequiredFields = false
  ;

  ImageFetchCancelInfo._() : super();
  factory ImageFetchCancelInfo({
    $core.String? url,
    $fixnum.Int64? textureId,
  }) {
    final _result = create();
    if (url != null) {
      _result.url = url;
    }
    if (textureId != null) {
      _result.textureId = textureId;
    }
    return _result;
  }
  factory ImageFetchCancelInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageFetchCancelInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageFetchCancelInfo clone() => ImageFetchCancelInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageFetchCancelInfo copyWith(void Function(ImageFetchCancelInfo) updates) => super.copyWith((message) => updates(message as ImageFetchCancelInfo)) as ImageFetchCancelInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageFetchCancelInfo create() => ImageFetchCancelInfo._();
  ImageFetchCancelInfo createEmptyInstance() => create();
  static $pb.PbList<ImageFetchCancelInfo> createRepeated() => $pb.PbList<ImageFetchCancelInfo>();
  @$core.pragma('dart2js:noInline')
  static ImageFetchCancelInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageFetchCancelInfo>(create);
  static ImageFetchCancelInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get textureId => $_getI64(1);
  @$pb.TagNumber(2)
  set textureId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTextureId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTextureId() => clearField(2);
}

