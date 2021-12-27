import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:beauty_app/services/firebase/cloud_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:async';

class FileUploadArea extends StatefulWidget {
  FileUploadArea({Key? key}) : super(key: key);

  @override
  _FileUploadAreaState createState() => _FileUploadAreaState();
}

class _FileUploadAreaState extends State<FileUploadArea> {
  List<String> _filesPath = [];

  _uploadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final Uint8List bytes = await image.readAsBytes();

    final fileUrl = await CloudStorage()
        .uploadFile(imageBytes: bytes, filePath: 'files/${DateTime.now()}.png');
    if (fileUrl != null)
      setState(() {
        _filesPath.add(fileUrl);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: _uploadImage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload,
                size: 50,
                color: Colors.grey,
              ),
              Center(
                child: Text(
                  "Upload Image",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ));
  }
}
