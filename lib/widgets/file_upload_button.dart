import 'dart:typed_data';

import 'package:beauty_app/services/firebase/cloud_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'exception_alert_dialog.dart';

class FileUploadArea extends StatefulWidget {
  final Function(String) onCountChanged;

  FileUploadArea({Key? key, required this.onCountChanged}) : super(key: key);

  @override
  _FileUploadAreaState createState() => _FileUploadAreaState();
}

class _FileUploadAreaState extends State<FileUploadArea> {
  List<String> _filesPath = [];
  bool _isLoading = false;
  _uploadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _isLoading = true;
    });
    final Uint8List bytes = await image.readAsBytes();
    try {
      final fileUrl = await CloudStorage()
          .uploadFile(imageBytes: bytes, filePath: 'files/${image.name}.png');
      if (fileUrl != null)
        setState(() {
          _filesPath.add(fileUrl);
          widget.onCountChanged(fileUrl);
          _isLoading = false;
        });
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: "File Upload Error", exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
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
        child: Column(
          children: [
            Container(
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
                    if (_isLoading)
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5,
            ),
            GridView.builder(
              shrinkWrap: true,
              //itemCount: images.length,
              itemCount: _filesPath.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Image.network(
                    _filesPath[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ],
        ));
  }
}
