import 'package:beauty_app/models/routes_class.dart';
import 'package:beauty_app/screens/authentication_screen.dart';
import 'package:beauty_app/screens/products_screen.dart';
import 'package:beauty_app/screens/upload_data_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDwPeB_L76rcuwwViLi2qFsgsAjy4EMR84",
        authDomain: "beautyapp-2c788.firebaseapp.com",
        projectId: "beautyapp-2c788",
        storageBucket: "beautyapp-2c788.appspot.com",
        messagingSenderId: "757308584361",
        appId: "1:757308584361:web:c6d543feba937d38f714b8",
        measurementId: "G-DF2QHR5NJ7"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Makdeck Admin',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: Routes().login,
        routes: {
          Routes().allProducts: (context) =>
              const ProductsScreen(), // Show All Products
          Routes().login: (context) =>
              const AuthenticationScreen(), // Log in Page
          Routes().addProduct: (context) =>
              const UploadDataScreen(), // Add Product Page
          Routes().editProduct: (context) =>
              const UploadDataScreen(), // Upload Product Page
        },
        home: const AuthenticationScreen());
  }
}
