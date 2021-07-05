///
//  Generated code. Do not modify.
//  source: method_call_result.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'enum.pbenum.dart' as $0;

class ImageResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageResult', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.O3)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'textureId', protoName: 'textureId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..e<$0.ImageTaskState>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: $0.ImageTaskState.initialized, valueOf: $0.ImageTaskState.valueOf, enumValues: $0.ImageTaskState.values)
    ..hasRequiredFields = false
  ;

  ImageResult._() : super();
  factory ImageResult({
    $core.int? code,
    $fixnum.Int64? textureId,
    $core.String? message,
    $core.String? url,
    $0.ImageTaskState? state,
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
  factory ImageResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageResult clone() => ImageResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageResult copyWith(void Function(ImageResult) updates) => super.copyWith((message) => updates(message as ImageResult)) as ImageResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageResult create() => ImageResult._();
  ImageResult createEmptyInstance() => create();
  static $pb.PbList<ImageResult> createRepeated() => $pb.PbList<ImageResult>();
  @$core.pragma('dart2js:noInline')
  static ImageResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageResult>(create);
  static ImageResult? _defaultInstance;

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
  $0.ImageTaskState get state => $_getN(4);
  @$pb.TagNumber(5)
  set state($0.ImageTaskState v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasState() => $_has(4);
  @$pb.TagNumber(5)
  void clearState() => clearField(5);
}

