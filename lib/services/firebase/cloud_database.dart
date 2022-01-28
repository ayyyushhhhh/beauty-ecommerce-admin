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
      await uploadCategoryProduct(product);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> uploadCategoryProduct(Map<String, dynamic> product) async {
    final String productpath =
        "Category/Products/${product["category"]}/${product["id"]}";

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

  Future<void> deleteProduct(
      {required String id, required String category}) async {
    final String productpath = "Products/$id";
    try {
      final DocumentReference<Map<String, dynamic>> cloudRef =
          _firestore.doc(productpath);
      await cloudRef.delete();
      await deleteCategoryProduct(id: id, category: category);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> deleteCategoryProduct(
      {required String id, required String category}) async {
    final String productpath = "Category/Products/$category/$id";
    try {
      final DocumentReference<Map<String, dynamic>> cloudRef =
          _firestore.doc(productpath);
      await cloudRef.delete();
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> uploadBanner(
      {required String banner, required List<String> bannerimages}) async {
    final String bannerpath = "Banners/$banner";
    final bannerMap = {
      "banner": banner,
      "bannerUrl": bannerimages,
    };
    try {
      final DocumentReference<Map<String, dynamic>> cloudRef =
          _firestore.doc(bannerpath);
      await cloudRef.set(bannerMap);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List> getBanners(
      {required String banner, required List<String> bannerimages}) async {
    const String bannerpath = "Banners/";

    try {
      final CollectionReference refrence = _firestore.collection(bannerpath);
      final QuerySnapshot productSnapshot = await refrence.get();
      final restoredBanners = [];
      final allData = productSnapshot.docs.map((doc) => doc.data()).toList();

      for (final data in allData) {
        final bannerMapdata = data as Map<String, dynamic>;
        restoredBanners.add({
          "banner": bannerMapdata["banner"],
          "bannerUrl": bannerMapdata["bannerUrl"],
        });
      }

      return restoredBanners;
    } on Exception {
      rethrow;
    }
  }
}
