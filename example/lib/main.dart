import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:texture_image/texture_image.dart' as $ti;
import 'package:texture_image/texture_image_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _images = <String>[
    'https://chingflowers.com.tw/wp-content/uploads/2020/10/AF4C4483-87A8-407F-B71D-3009CDEF6EF2.jpeg',
    'httbs://wallpapercave.com/wp/Rwl8nSj.jpg',
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
    "http://img.ah-suuwaa.com/20aa679b-0ffe-4cfd-b13f-bc25cf76807a.png",
    "http://img.ah-suuwaa.com/daa1589f-2375-43d2-90e3-1f50e6139950.png",
    "http://img.ah-suuwaa.com/80b34663-dec7-4b5b-811f-337ae2e6ee46.png",
    "http://img.ah-suuwaa.com/6dc57610-73d4-4100-a5b8-aca6cd9e1a29.png",
    "http://img.ah-suuwaa.com/547da23f-8171-45da-91ce-93d8bb12d112.png",
    "http://img.ah-suuwaa.com/cd461d30-5202-4c04-bc81-1b9cb9def4d5.png",
    "http://img.ah-suuwaa.com/ecadf210-ca27-4f4c-b309-1093a2588c68.png",
    "http://img.ah-suuwaa.com/396a7f01-04b6-4be4-8146-7bade95db0c5.jpg",
    "http://img.ah-suuwaa.com/fcf1090b-ee7c-4dfc-a9ba-3bfdbb01059a.png",
    "https://thirdwx.qlogo.cn/mmopen/vi_32/WwaGjhABeBtGw1wAAFuOTToN8eHubueRzbXCAZ6ALVbYcSpDJbszoWn8JEBp59N17fPJAkjtFQQ7LNMM9870Eg/132",
    "http://img.ah-suuwaa.com/f23df587-b86b-4d10-ba89-d7ae54a42aef.png",
    "http://img.ah-suuwaa.com/b63ac75e-f998-45a6-90a7-b159787228f1.png",
    "http://img.ah-suuwaa.com/e7e68996-eb79-4a58-b827-37dc5b7946af.png",
    "http://img.ah-suuwaa.com/3d1e0ee5-6cca-497f-b362-07698567d354.png",
    "http://img.ah-suuwaa.com/6b7f2406-441c-487d-ac24-c47d4b93f43c.png",
    "http://img.ah-suuwaa.com/10f70b6e-6f38-4cd9-b53c-eae22ae31588.png",
    "http://img.ah-suuwaa.com/b9859f52-83a2-414f-a324-9ab135f4c8a0.png",
    "http://img.ah-suuwaa.com/9b22366e-06f7-4f31-8875-ee98bdc8871a.png",
    "http://img.ah-suuwaa.com/b958e488-f0f9-47ec-a410-1aa5aba4774c.png",
    "http://img.ah-suuwaa.com/97d0d1d3-81fa-45ca-92bd-cdf090980825.png",
    "http://img.ah-suuwaa.com/74430c7e-d626-407a-90d6-5c7a3240e364.png",
    "http://img.ah-suuwaa.com/b6777e30-2c48-440e-90f6-84976f9a6ddd.png",
    "http://img.ah-suuwaa.com/57333f69-ee0a-43fc-b423-7235bc825ab9.png",
    "http://img.ah-suuwaa.com/a9b9c9e2-8d4d-4b6b-b8a8-1844bf5e63d3.png",
    "http://img.ah-suuwaa.com/6f3766f9-3ab3-4e4a-9afb-f8e016ea94df.png",
    "http://img.ah-suuwaa.com/1ee72b25-1f9d-49e4-ba22-6b0891f0579d.png",
    "http://img.ah-suuwaa.com/e68f8579-100d-42fb-9392-e5128e687053.png",
    "http://img.ah-suuwaa.com/98828234-4356-4e39-b20f-0c03dd4d5456.png",
    "http://img.ah-suuwaa.com/2b848e87-8fd4-4b0a-aa8f-83697d5d73ef.png",
    "http://img.ah-suuwaa.com/7fd4cddb-e26e-4c9e-abdd-13ff8ca38934.png",
    "http://img.ah-suuwaa.com/5312af45-7c4c-4417-a12d-167c3515b95d.png",
    "https://img.ah-suuwaa.com/Boy.png",
    "http://img.ah-suuwaa.com/937c7fc7-9f34-4805-a316-ae1e128d07c6.png",
    "http://img.ah-suuwaa.com/3c79dbe8-c3ff-42b3-8b69-08b76b80a0ee.png",
    "http://img.ah-suuwaa.com/14f395d9-a7e0-46cd-84c8-d45d8f65cc2e.png",
    "http://img.ah-suuwaa.com/2cf028a0-42bf-473c-b512-12fa320af130.png",
    "http://img.ah-suuwaa.com/77722208-197b-4f8d-a1c9-81e429350d98.png",
    "http://img.ah-suuwaa.com/7e3c5c53-b3b9-4f9a-b3ce-4a7b54b64a0d.png",
    "http://img.ah-suuwaa.com/7f6a6401-0e34-4198-8e35-0a35c29bdb64.png",
    "http://img.ah-suuwaa.com/00d741c9-78ad-431e-b442-225c55adf683.png",
    "http://img.ah-suuwaa.com/6d0e8018-86f7-48f8-9ef4-6f5282cd8a94.png",
    "http://img.ah-suuwaa.com/6e1820d7-0232-48a1-9be0-a7324f71cb2f.png",
    "http://img.ah-suuwaa.com/e196433c-79a1-4d90-92fd-5154e06b5caa.png",
    "http://img.ah-suuwaa.com/0f93a08b-7f39-4682-a8c1-476ae33a49f1.png",
    "http://img.ah-suuwaa.com/7d8174dd-ef27-4782-ac1a-fb86f2502519.png",
    "http://img.ah-suuwaa.com/9681d55a-cd6d-4eda-b7ea-daf94ff487a4.png",
    "http://img.ah-suuwaa.com/291e040c-1e44-40a7-8ad3-dbb9f10b3169.png",
    "http://img.ah-suuwaa.com/13eea5cd-a523-4a2e-9a86-69d8fd49a5b8.png",
    "http://img.ah-suuwaa.com/6365200f-f359-400d-bdc6-5e0ab4ab3dec.png",
    "http://img.ah-suuwaa.com/f18c8120-8247-4913-ac2c-9226c117655d.png",
    "http://img.ah-suuwaa.com/9a740420-cdbf-4b0e-a227-b7230bf80533.png",
    "http://img.ah-suuwaa.com/3250dc5e-326e-43ec-9285-15ed8f88b8f7.png",
    "http://img.ah-suuwaa.com/8fa51af6-b1d1-4c7e-a442-4b0929e846cb.png",
    "http://img.ah-suuwaa.com/4829609b-5e75-4e23-94fb-fb5d30156691.png",
    "http://img.ah-suuwaa.com/0ad52b80-7c0a-485c-a974-a175cceef77d.png",
    "http://img.ah-suuwaa.com/9a5d5c8d-92a0-4f3a-aa50-2cf35482a556.jpg",
    "http://img.ah-suuwaa.com/86653994-edfc-412d-837a-73c873982dd5.png"
  ];

  final useTextureImage = true;

  @override
  void initState() {
    super.initState();
    TextureImagePlugin.updateConfig();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return LayoutBuilder(
              builder: (context, constraint) {
                return useTextureImage
                    ? $ti.TextureImage(
                        _images[index],
                        width: constraint.maxWidth,
                        height: constraint.maxHeight,
                        fit: $ti.BoxFit.cover,
                        placeholderPath: 'lib/assets/ic_placeholder.png',
                        errorPlaceholderPath: 'lib/assets/ic_error_1.png',
                      )
                    : CachedNetworkImage(
                        imageUrl: _images[index],
                        height: constraint.maxHeight,
                        fit: BoxFit.cover,
                        memCacheWidth: constraint.maxWidth.toInt(),
                        memCacheHeight: constraint.maxHeight.toInt(),
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
