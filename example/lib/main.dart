import 'package:flutter/material.dart';
import 'package:texture_image/texture_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _images = <String>[
    'https://wallpapercave.com/wp/Rwl8nSj.jpg',
    'https://www.swellnet.com/sites/default/files/inline-images/img_0490-2.jpg',
    'https://cdn.wallpapersafari.com/58/43/z2Ixq3.jpg',
    'https://free4kwallpapers.com/uploads/originals/2019/12/24/surfing-wallpaper.jpg',
    'https://wallpapercave.com/wp/wp5555833.jpg',
    'https://images.wallpaperscraft.com/image/surfer_surfing_waves_146724_3840x2160.jpg',
    'https://getwallpapers.com/wallpaper/full/8/4/c/1028446-new-surf-beach-wallpaper-3000x1999-ipad.jpg',
    'https://images.wallpapersden.com/image/download/sea-waves-surf_ZmloaW6UmZqaraWkpJRqaG5rrWhqbmw.jpg',
    'https://wallpapercave.com/wp/wp4800435.jpg',
    'https://wallpaperaccess.com/full/1950266.jpg',
    'https://wallpaperaccess.com/full/2980500.jpg',
    'https://wallpapercrafter.com/desktop/206459-aerial-drone-shot-of-red-deserts-of-oljato-monumen.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView.builder(
          itemCount: _images.length,
          itemBuilder: (context, index) {
            // return CachedNetworkImage(
            //   imageUrl: _images[index],
            //   height: 180,
            // );
            return TextureImage(
              _images[index],
              width: 375,
              height: 180,
            );
          },
        ),
      ),
    );
  }
}
