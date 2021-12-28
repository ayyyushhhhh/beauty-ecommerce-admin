import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorage {
  Future<String?> uploadFile(
      {required String filePath, required Uint8List imageBytes}) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref(filePath);
      await storageReference.putData(
          imageBytes, SettableMetadata(contentType: 'image/png'));
      final String url = await storageReference.getDownloadURL();
      return url;
    } on FirebaseException {
      rethrow;
    }
  }
}
