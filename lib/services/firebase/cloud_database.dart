import 'package:beauty_app/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudDatabase {
  late FirebaseFirestore _firestore;
  // ignore: non_constant_identifier_names
  CloudDatabase() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> uploadProductData(Map<String, dynamic> product) async {
    final String productpath = "Products/${product["id"]}";

    try {
      final DocumentReference<Map<String, dynamic>> cloudRef =
          _firestore.doc(productpath);
      await cloudRef.set(product);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsData() async {
    const String productpath = "Products/";
    try {
      final CollectionReference refrence = _firestore.collection(productpath);
      final QuerySnapshot productSnapshot = await refrence.get();
      final List<ProductModel> restoredProdcuts = [];
      final allData = productSnapshot.docs.map((doc) => doc.data()).toList();

      for (final data in allData) {
        restoredProdcuts
            .add(ProductModel.fromMap(data! as Map<String, dynamic>));
      }
      return restoredProdcuts;
    } on Exception {
      rethrow;
    }
  }
}
