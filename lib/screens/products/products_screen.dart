import 'package:beauty_app/models/product_model.dart';
import 'package:beauty_app/models/routes_class.dart';
import 'package:beauty_app/services/firebase/cloud_database.dart';
import 'package:beauty_app/widgets/product_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Makdeck Products",
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh)),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, Routes().login);
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            if (FirebaseAuth.instance.currentUser != null) {
              Navigator.pushNamed(context, Routes().addProduct);
            }
          },
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: CloudDatabase().getProductsData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Product Avaiable"),
                );
              }
              if (snapshot.hasData) {
                List<ProductModel> products = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductContainer(product: products[index]);
                  },
                );
              } else {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
