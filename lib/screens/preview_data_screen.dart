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
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: widget.product.images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Image.network(image),
                      );
                    },
                  );
                }).toList(),
              ),
              _buildDataWidget(
                  title: "Product Name", value: widget.product.name),
              SizedBox(height: 10),
              _buildDataWidget(
                  title: "Product Name", value: widget.product.mrp),
              SizedBox(height: 10),
              _buildDataWidget(
                  title: "Product Name", value: widget.product.quantity),
              SizedBox(height: 10),
              _buildDataWidget(
                  title: "Product Description",
                  value: widget.product.productDescription),
              SizedBox(height: 10),
              _buildDataWidget(
                  title: "Benefits", value: widget.product.benefits),
              SizedBox(height: 10),
              _buildDataWidget(
                  title: "Product Name", value: widget.product.ingredients),
              SizedBox(height: 10),
              _buildDataWidget(
                  title: "Product Name",
                  value: widget.product.addressofImporter),
              SizedBox(height: 10),
              _buildDataWidget(
                  title: "Product Name", value: widget.product.nameOfImporter),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _uploadProduct,
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Align(
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
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
