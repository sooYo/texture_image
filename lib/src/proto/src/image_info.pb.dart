///
//  Generated code. Do not modify.
//  source: image_info.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'border_radius.pb.dart' as $0;

class TextureImageInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TextureImageInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorPlaceholder', protoName: 'errorPlaceholder')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder')
    ..aOM<$0.ImageBorderRadius>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'borderRadius', protoName: 'borderRadius', subBuilder: $0.ImageBorderRadius.create)
    ..hasRequiredFields = false
  ;

  TextureImageInfo._() : super();
  factory TextureImageInfo({
    $core.String? url,
    $core.int? width,
    $core.int? height,
    $core.String? errorPlaceholder,
    $core.String? placeholder,
    $0.ImageBorderRadius? borderRadius,
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
    if (borderRadius != null) {
      _result.borderRadius = borderRadius;
    }
    return _result;
  }
  factory TextureImageInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TextureImageInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TextureImageInfo clone() => TextureImageInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TextureImageInfo copyWith(void Function(TextureImageInfo) updates) => super.copyWith((message) => updates(message as TextureImageInfo)) as TextureImageInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextureImageInfo create() => TextureImageInfo._();
  TextureImageInfo createEmptyInstance() => create();
  static $pb.PbList<TextureImageInfo> createRepeated() => $pb.PbList<TextureImageInfo>();
  @$core.pragma('dart2js:noInline')
  static TextureImageInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextureImageInfo>(create);
  static TextureImageInfo? _defaultInstance;

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
  $0.ImageBorderRadius get borderRadius => $_getN(5);
  @$pb.TagNumber(6)
  set borderRadius($0.ImageBorderRadius v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasBorderRadius() => $_has(5);
  @$pb.TagNumber(6)
  void clearBorderRadius() => clearField(6);
  @$pb.TagNumber(6)
  $0.ImageBorderRadius ensureBorderRadius() => $_ensure(5);
}

