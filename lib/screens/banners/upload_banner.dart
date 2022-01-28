import 'package:beauty_app/services/firebase/cloud_database.dart';
import 'package:beauty_app/widgets/file_upload_area.dart';
import 'package:flutter/material.dart';

class UploadBanners extends StatefulWidget {
  final List<String> previewImages;
  final String bannerString;
  const UploadBanners(
      {Key? key, required this.previewImages, required this.bannerString})
      : super(key: key);

  @override
  _UploadBannersState createState() => _UploadBannersState();
}

class _UploadBannersState extends State<UploadBanners> {
  // ignore: prefer_final_fields
  List<String> _images = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Banners"),
        actions: [
          GestureDetector(
              onTap: () {
                if (_images.isNotEmpty) {
                  CloudDatabase().uploadBanner(
                      banner: widget.bannerString, bannerimages: _images);
                  Navigator.of(context);
                }
              },
              child: const Text("Post")),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FileUploadArea(
                imagePaths: widget.previewImages,
                onCountChanged: (imageurl, index) {
                  if (imageurl != null) {
                    _images.add(imageurl);
                  } else {
                    _images.removeAt(index!);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
