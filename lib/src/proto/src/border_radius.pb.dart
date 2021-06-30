///
//  Generated code. Do not modify.
//  source: border_radius.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ImageBorderRadius extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageBorderRadius', createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topLeft', $pb.PbFieldType.OF, protoName: 'topLeft')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topRight', $pb.PbFieldType.OF, protoName: 'topRight')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomLeft', $pb.PbFieldType.OF, protoName: 'bottomLeft')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomRight', $pb.PbFieldType.OF, protoName: 'bottomRight')
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
  set topLeft($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTopLeft() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopLeft() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get topRight => $_getN(1);
  @$pb.TagNumber(2)
  set topRight($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTopRight() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopRight() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get bottomLeft => $_getN(2);
  @$pb.TagNumber(3)
  set bottomLeft($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBottomLeft() => $_has(2);
  @$pb.TagNumber(3)
  void clearBottomLeft() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get bottomRight => $_getN(3);
  @$pb.TagNumber(4)
  set bottomRight($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBottomRight() => $_has(3);
  @$pb.TagNumber(4)
  void clearBottomRight() => clearField(4);
}

