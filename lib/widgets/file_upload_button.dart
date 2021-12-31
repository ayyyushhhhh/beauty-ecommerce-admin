import 'dart:typed_data';

import 'package:beauty_app/services/firebase/cloud_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'exception_alert_dialog.dart';

class FileUploadArea extends StatefulWidget {
  final Function(String?, int?) onCountChanged;
  final List<String>? imagePaths;
  const FileUploadArea(
      {Key? key, required this.onCountChanged, this.imagePaths})
      : super(key: key);

  @override
  _FileUploadAreaState createState() => _FileUploadAreaState();
}

class _FileUploadAreaState extends State<FileUploadArea> {
  List<String> _filesPath = [];

  @override
  void initState() {
    super.initState();
    if (widget.imagePaths != null) {
      _filesPath = widget.imagePaths!;
    }
  }

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
        // ignore: curly_braces_in_flow_control_structures
        setState(() {
          _filesPath.add(fileUrl);
          widget.onCountChanged(fileUrl, 0);
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
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
              onTap: _uploadImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload,
                    size: 50,
                    color: Colors.grey,
                  ),
                  const Center(
                    child: Text(
                      "Upload Image",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  if (_isLoading)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            GridView.builder(
              shrinkWrap: true,
              //itemCount: images.length,
              itemCount: _filesPath.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return Stack(children: [
                  Image.network(
                    _filesPath[index],
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _filesPath.removeAt(index);
                          widget.onCountChanged(null, index);
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: const Icon(Icons.minimize_outlined),
                      ),
                    ),
                  ),
                ]);
              },
            ),
          ],
        ));
  }
}
