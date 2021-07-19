///
//  Generated code. Do not modify.
//  source: image_utils.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'image_utils.pbenum.dart';

export 'image_utils.pbenum.dart';

class BorderRadius extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BorderRadius', createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topLeft', $pb.PbFieldType.OD, protoName: 'topLeft')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topRight', $pb.PbFieldType.OD, protoName: 'topRight')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomLeft', $pb.PbFieldType.OD, protoName: 'bottomLeft')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomRight', $pb.PbFieldType.OD, protoName: 'bottomRight')
    ..hasRequiredFields = false
  ;

  BorderRadius._() : super();
  factory BorderRadius({
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
  factory BorderRadius.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BorderRadius.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BorderRadius clone() => BorderRadius()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BorderRadius copyWith(void Function(BorderRadius) updates) => super.copyWith((message) => updates(message as BorderRadius)) as BorderRadius; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BorderRadius create() => BorderRadius._();
  BorderRadius createEmptyInstance() => create();
  static $pb.PbList<BorderRadius> createRepeated() => $pb.PbList<BorderRadius>();
  @$core.pragma('dart2js:noInline')
  static BorderRadius getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BorderRadius>(create);
  static BorderRadius? _defaultInstance;

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

class Geometry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Geometry', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.O3)
    ..e<BoxFit>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fit', $pb.PbFieldType.OE, defaultOrMaker: BoxFit.fill, valueOf: BoxFit.valueOf, enumValues: BoxFit.values)
    ..aOM<BorderRadius>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'borderRadius', protoName: 'borderRadius', subBuilder: BorderRadius.create)
    ..hasRequiredFields = false
  ;

  Geometry._() : super();
  factory Geometry({
    $core.int? width,
    $core.int? height,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (fit != null) {
      _result.fit = fit;
    }
    if (borderRadius != null) {
      _result.borderRadius = borderRadius;
    }
    return _result;
  }
  factory Geometry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Geometry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Geometry clone() => Geometry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Geometry copyWith(void Function(Geometry) updates) => super.copyWith((message) => updates(message as Geometry)) as Geometry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Geometry create() => Geometry._();
  Geometry createEmptyInstance() => create();
  static $pb.PbList<Geometry> createRepeated() => $pb.PbList<Geometry>();
  @$core.pragma('dart2js:noInline')
  static Geometry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Geometry>(create);
  static Geometry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get width => $_getIZ(0);
  @$pb.TagNumber(1)
  set width($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get height => $_getIZ(1);
  @$pb.TagNumber(2)
  set height($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  BoxFit get fit => $_getN(2);
  @$pb.TagNumber(3)
  set fit(BoxFit v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFit() => $_has(2);
  @$pb.TagNumber(3)
  void clearFit() => clearField(3);

  @$pb.TagNumber(4)
  BorderRadius get borderRadius => $_getN(3);
  @$pb.TagNumber(4)
  set borderRadius(BorderRadius v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBorderRadius() => $_has(3);
  @$pb.TagNumber(4)
  void clearBorderRadius() => clearField(4);
  @$pb.TagNumber(4)
  BorderRadius ensureBorderRadius() => $_ensure(3);
}

