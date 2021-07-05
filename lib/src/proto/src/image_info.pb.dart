///
//  Generated code. Do not modify.
//  source: image_info.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'enum.pbenum.dart' as $0;

class ImageRequestInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageRequestInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorPlaceholder', protoName: 'errorPlaceholder')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder')
    ..e<$0.BoxFit>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fit', $pb.PbFieldType.OE, defaultOrMaker: $0.BoxFit.fill, valueOf: $0.BoxFit.valueOf, enumValues: $0.BoxFit.values)
    ..aOM<ImageBorderRadius>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'borderRadius', protoName: 'borderRadius', subBuilder: ImageBorderRadius.create)
    ..hasRequiredFields = false
  ;

  ImageRequestInfo._() : super();
  factory ImageRequestInfo({
    $core.String? url,
    $core.int? width,
    $core.int? height,
    $core.String? errorPlaceholder,
    $core.String? placeholder,
    $0.BoxFit? fit,
    ImageBorderRadius? borderRadius,
  }) {
    final _result = create();
    if (url != null) {
      _result.url = url;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (errorPlaceholder != null) {
      _result.errorPlaceholder = errorPlaceholder;
    }
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (fit != null) {
      _result.fit = fit;
    }
    if (borderRadius != null) {
      _result.borderRadius = borderRadius;
    }
    return _result;
  }
  factory ImageRequestInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageRequestInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageRequestInfo clone() => ImageRequestInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageRequestInfo copyWith(void Function(ImageRequestInfo) updates) => super.copyWith((message) => updates(message as ImageRequestInfo)) as ImageRequestInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageRequestInfo create() => ImageRequestInfo._();
  ImageRequestInfo createEmptyInstance() => create();
  static $pb.PbList<ImageRequestInfo> createRepeated() => $pb.PbList<ImageRequestInfo>();
  @$core.pragma('dart2js:noInline')
  static ImageRequestInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageRequestInfo>(create);
  static ImageRequestInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get width => $_getIZ(1);
  @$pb.TagNumber(2)
  set width($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get height => $_getIZ(2);
  @$pb.TagNumber(3)
  set height($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeight() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorPlaceholder => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorPlaceholder($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrorPlaceholder() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorPlaceholder() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get placeholder => $_getSZ(4);
  @$pb.TagNumber(5)
  set placeholder($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlaceholder() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlaceholder() => clearField(5);

  @$pb.TagNumber(6)
  $0.BoxFit get fit => $_getN(5);
  @$pb.TagNumber(6)
  set fit($0.BoxFit v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFit() => $_has(5);
  @$pb.TagNumber(6)
  void clearFit() => clearField(6);

  @$pb.TagNumber(7)
  ImageBorderRadius get borderRadius => $_getN(6);
  @$pb.TagNumber(7)
  set borderRadius(ImageBorderRadius v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasBorderRadius() => $_has(6);
  @$pb.TagNumber(7)
  void clearBorderRadius() => clearField(7);
  @$pb.TagNumber(7)
  ImageBorderRadius ensureBorderRadius() => $_ensure(6);
}

class ImageRequestCancelInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageRequestCancelInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'textureId', protoName: 'textureId')
    ..hasRequiredFields = false
  ;

  ImageRequestCancelInfo._() : super();
  factory ImageRequestCancelInfo({
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
  factory ImageRequestCancelInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageRequestCancelInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageRequestCancelInfo clone() => ImageRequestCancelInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageRequestCancelInfo copyWith(void Function(ImageRequestCancelInfo) updates) => super.copyWith((message) => updates(message as ImageRequestCancelInfo)) as ImageRequestCancelInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageRequestCancelInfo create() => ImageRequestCancelInfo._();
  ImageRequestCancelInfo createEmptyInstance() => create();
  static $pb.PbList<ImageRequestCancelInfo> createRepeated() => $pb.PbList<ImageRequestCancelInfo>();
  @$core.pragma('dart2js:noInline')
  static ImageRequestCancelInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageRequestCancelInfo>(create);
  static ImageRequestCancelInfo? _defaultInstance;

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

class ImageBorderRadius extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageBorderRadius', createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topLeft', $pb.PbFieldType.OD, protoName: 'topLeft')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topRight', $pb.PbFieldType.OD, protoName: 'topRight')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomLeft', $pb.PbFieldType.OD, protoName: 'bottomLeft')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomRight', $pb.PbFieldType.OD, protoName: 'bottomRight')
    ..hasRequiredFields = false
  ;

  ImageBorderRadius._() : super();
  factory ImageBorderRadius({
    $core.double? topLeft,
    $core.double? topRight,
    $core.double? bottomLeft,
    $core.double? bottomRight,
  }) {
    final _result = create();
    if (topLeft != null) {
      _result.topLeft = topLeft;
    }
    if (topRight != null) {
      _result.topRight = topRight;
    }
    if (bottomLeft != null) {
      _result.bottomLeft = bottomLeft;
    }
    if (bottomRight != null) {
      _result.bottomRight = bottomRight;
    }
    return _result;
  }
  factory ImageBorderRadius.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageBorderRadius.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageBorderRadius clone() => ImageBorderRadius()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageBorderRadius copyWith(void Function(ImageBorderRadius) updates) => super.copyWith((message) => updates(message as ImageBorderRadius)) as ImageBorderRadius; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageBorderRadius create() => ImageBorderRadius._();
  ImageBorderRadius createEmptyInstance() => create();
  static $pb.PbList<ImageBorderRadius> createRepeated() => $pb.PbList<ImageBorderRadius>();
  @$core.pragma('dart2js:noInline')
  static ImageBorderRadius getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageBorderRadius>(create);
  static ImageBorderRadius? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get topLeft => $_getN(0);
  @$pb.TagNumber(1)
  set topLeft($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTopLeft() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopLeft() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get topRight => $_getN(1);
  @$pb.TagNumber(2)
  set topRight($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTopRight() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopRight() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get bottomLeft => $_getN(2);
  @$pb.TagNumber(3)
  set bottomLeft($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBottomLeft() => $_has(2);
  @$pb.TagNumber(3)
  void clearBottomLeft() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get bottomRight => $_getN(3);
  @$pb.TagNumber(4)
  set bottomRight($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBottomRight() => $_has(3);
  @$pb.TagNumber(4)
  void clearBottomRight() => clearField(4);
}

