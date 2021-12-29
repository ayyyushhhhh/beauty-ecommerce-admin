import 'package:beauty_app/models/product_model.dart';
import 'package:beauty_app/screens/upload_data_screen.dart';
import 'package:beauty_app/services/firebase/cloud_database.dart';
import 'package:beauty_app/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UploadDataScreen()));
        },
      ),
      body: FutureBuilder(
        future: CloudDatabase().getProductsData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductContainer(product: products[index]);
              },
            );
          } else {
            return Center(
              child: Text("No Products Avaiable"),
            );
          }
        },
      ),
    );
  }
}
