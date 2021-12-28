import 'package:cloud_firestore/cloud_firestore.dart';

class CloudDatabase {
  late FirebaseFirestore _firestore;
  // ignore: non_constant_identifier_names
  CloudDatabase() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> uploadProductData(Map<String, dynamic> product) async {
    final String productpath =
        "Data/Products/${product["id"]}/${product["name"]}";

    try {
      final DocumentReference<Map<String, dynamic>> cloudRef =
          _firestore.doc(productpath);
      await cloudRef.set(product);
    } on FirebaseException {
      rethrow;
    }
  }
}
