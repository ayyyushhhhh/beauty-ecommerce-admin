import 'package:beauty_app/models/product_model.dart';
import 'package:beauty_app/services/firebase/cloud_database.dart';
import 'package:beauty_app/widgets/exception_alert_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final ProductModel product;

  const PreviewScreen({Key? key, required this.product}) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  aspectRatio: 1 / 1,
                ),
                items: widget.product.images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Image.network(image),
                      );
                    },
                  );
                }).toList(),
              ),
              _buildDataWidget(
                  title: "Product Name", value: widget.product.name),
              const SizedBox(height: 10),
              _buildDataWidget(
                  title: "Price", value: "₹ " + widget.product.mrp),
              const SizedBox(height: 10),
              _buildDataWidget(
                  title: "Quantity", value: widget.product.quantity),
              const SizedBox(height: 10),
              _buildDataWidget(
                  title: "Product Description",
                  value: widget.product.productDescription),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Cruelty Free: "),
                        const SizedBox(width: 10),
                        Checkbox(
                            value: widget.product.crueltyFree,
                            onChanged: (value) {}),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("In Stocks: "),
                        const SizedBox(width: 10),
                        Checkbox(
                            value: widget.product.inStocks,
                            onChanged: (value) {}),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildDataWidget(
                  title: "Benefits", value: widget.product.benefits),
              const SizedBox(height: 10),
              _buildDataWidget(
                  title: "Ingredients", value: widget.product.ingredients),
              const SizedBox(height: 10),
              _buildDataWidget(
                  title: "Importer Address",
                  value: widget.product.addressofImporter),
              const SizedBox(height: 10),
              _buildDataWidget(
                  title: "Importer Name", value: widget.product.nameOfImporter),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _uploadProduct,
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "SUBMIT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _uploadProduct() {
    final CloudDatabase cloudDatabase = CloudDatabase();
    try {
      cloudDatabase.uploadProductData(widget.product.toMap());
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: "Some Error Occured!", exception: e);
    }
  }

  Widget _buildDataWidget({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
