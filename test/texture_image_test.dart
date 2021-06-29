import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:texture_image/texture_image_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('texture_image');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TextureImagePlugin.platformVersion, '42');
  });
}
