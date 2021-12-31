// ignore_for_file: avoid_unnecessary_containers

import 'package:beauty_app/models/product_model.dart';
import 'package:beauty_app/screens/preview_data_screen.dart';
import 'package:beauty_app/screens/upload_data_screen.dart';
import 'package:beauty_app/services/firebase/cloud_database.dart';
import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  final ProductModel product;
  const ProductContainer({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.network(product.images[0]),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(product.id.toString()),
                      const SizedBox(width: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            CloudDatabase().deleteProduct(id: product.id);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '₹ ${product.mrp}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "Importer Name : ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: product.nameOfImporter,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "PREVIEW",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadDataScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "EDIT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
