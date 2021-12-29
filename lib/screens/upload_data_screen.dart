// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:beauty_app/models/product_model.dart';
import 'package:beauty_app/screens/preview_data_screen.dart';
import 'package:beauty_app/widgets/error_widget.dart';

import 'package:beauty_app/widgets/file_upload_button.dart';

import 'package:flutter/material.dart';
import 'package:zefyrka/zefyrka.dart';

enum _textFieldType {
  Name,
  MRP,
  Quantity,
  ProductDescription,
  Features,
  Benefits,
  Ingredients,
  CountryOfOrigin,
  NameOfImporter,
  ImporterAddress,
}

class UploadDataScreen extends StatefulWidget {
  final ProductModel? product;
  const UploadDataScreen({Key? key, this.product}) : super(key: key);

  @override
  _UploadDataScreenState createState() => _UploadDataScreenState();
}

class _UploadDataScreenState extends State<UploadDataScreen> {
  List<String> _images = [];
  String _name = "";
  String _mrp = "";
  String _quantity = "";
  late String _productDescription = "";
  late String _features = "";
  late String _benefits = "";
  late String _ingredients = "";
  late bool _inStocks = true;
  late bool _crueltyFree = true;
  late String _countryofOrigin = "";
  late String _nameOfImporter = "";
  late String _addressofImporter = "";
  late String id;
  final ZefyrController _controller = ZefyrController();

  @override
  void initState() {
    super.initState();
    if (widget.product == null) {
      id = Random().nextInt(1000000).toString();
    } else {
      id = widget.product!.id.toString();
      _name = widget.product!.name;
      _mrp = widget.product!.mrp.toString();
      _quantity = widget.product!.quantity.toString();
      _productDescription = widget.product!.productDescription;
      _features = widget.product!.features;
      _benefits = widget.product!.benefits;
      _ingredients = widget.product!.ingredients;
      _inStocks = widget.product!.inStocks;
      _crueltyFree = widget.product!.crueltyFree;
      _countryofOrigin = widget.product!.countryofOrigin;
      _nameOfImporter = widget.product!.nameOfImporter;
      _addressofImporter = widget.product!.addressofImporter;
      _images = widget.product!.images;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Data"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              FileUploadArea(
                imagePaths: _images,
                onCountChanged: (String imageurl) {
                  _images.add(imageurl);
                },
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Name,
                  height: 50,
                  initialData: _name),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Description",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.ProductDescription,
                  height: 200,
                  initialData: _productDescription),
              const SizedBox(height: 10),
              _buildAdditionalDetails(),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Features",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Features,
                  height: 200,
                  initialData: _features),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Benefits",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Benefits,
                  height: 200,
                  initialData: _benefits),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Ingredients,
                  height: 200,
                  initialData: _ingredients),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Country of Origin",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.CountryOfOrigin,
                  height: 50,
                  initialData: _countryofOrigin),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Importer Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.NameOfImporter,
                  height: 100,
                  initialData: _nameOfImporter),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Address Importer",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.ImporterAddress,
                  height: 100,
                  initialData: _addressofImporter),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_addressofImporter != "" &&
                      _images.isNotEmpty &&
                      _ingredients != "" &&
                      _benefits != "" &&
                      _countryofOrigin != "" &&
                      _features != "" &&
                      _nameOfImporter != "" &&
                      _name != "" &&
                      _productDescription != "" &&
                      _quantity != "" &&
                      _mrp != "") {
                    _sendPreview();
                  } else {
                    showAlertDialog(context,
                        title: "Error",
                        content: "Please fill all the fields",
                        defaultActionText: "OK");
                  }
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
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
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendPreview() {
    final ProductModel product = ProductModel(
        id: id,
        images: _images,
        name: _name,
        mrp: _mrp,
        quantity: _quantity,
        productDescription: _productDescription,
        features: _features,
        benefits: _benefits,
        ingredients: _ingredients,
        inStocks: _inStocks,
        crueltyFree: _crueltyFree,
        countryofOrigin: _countryofOrigin,
        nameOfImporter: _nameOfImporter,
        addressofImporter: _addressofImporter);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PreviewScreen(product: product);
        },
      ),
    );
  }

  Widget _buildTextField({
    required double height,
    required _textFieldType inputTextFieldType,
    required String initialData,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height,
      // margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: TextEditingController()..text = initialData,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        minLines: null,
        maxLines: null,
        onChanged: (value) {
          if (inputTextFieldType == _textFieldType.Name) {
            _name = value;
          } else if (inputTextFieldType == _textFieldType.MRP) {
            _mrp = value;
          } else if (inputTextFieldType == _textFieldType.Quantity) {
            _quantity = value;
          } else if (inputTextFieldType == _textFieldType.ProductDescription) {
            _productDescription = value;
          } else if (inputTextFieldType == _textFieldType.Features) {
            _features = value;
          } else if (inputTextFieldType == _textFieldType.Benefits) {
            _benefits = value;
          } else if (inputTextFieldType == _textFieldType.Ingredients) {
            _ingredients = value;
          } else if (inputTextFieldType == _textFieldType.NameOfImporter) {
            _nameOfImporter = value;
          } else if (inputTextFieldType == _textFieldType.CountryOfOrigin) {
            _countryofOrigin = value;
          } else if (inputTextFieldType == _textFieldType.ImporterAddress) {
            _addressofImporter = value;
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildTextField({
  //   required double height,
  //   required _textFieldType inputTextFieldType,
  // }) {
  //   return Container(
  //       width: double.infinity,
  //       padding: EdgeInsets.all(10),
  //       height: height,
  //       margin: const EdgeInsets.only(left: 20, right: 20),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //           color: Colors.black,
  //           width: 1,
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           ZefyrToolbar.basic(
  //             controller: _controller,
  //           ),
  //           ZefyrEditor(
  //             controller: _controller,
  //           ),
  //         ],
  //       ));
  // }

  Widget _buildAdditionalDetails() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            children: [
              Row(
                children: [
                  const Text(
                    "MRP : ₹",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: _buildTextField(
                          height: 40,
                          inputTextFieldType: _textFieldType.MRP,
                          initialData: _mrp)),
                  const SizedBox(width: 10),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Quantity : ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: _buildTextField(
                          height: 40,
                          inputTextFieldType: _textFieldType.Quantity,
                          initialData: _quantity)),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  const Text(
                    'In Stocks?',
                    style: TextStyle(fontSize: 24),
                  ), //Text
                  const SizedBox(width: 10), //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: _inStocks,
                    onChanged: (value) {
                      setState(() {
                        _inStocks = value!;
                      });
                    },
                  ), //Checkbox
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Cruelty Free ? ',
                    style: TextStyle(fontSize: 24),
                  ), //Text
                  const SizedBox(width: 10), //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: _crueltyFree,
                    onChanged: (value) {
                      setState(() {
                        _crueltyFree = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    "MRP : ₹",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: _buildTextField(
                          height: 40,
                          inputTextFieldType: _textFieldType.MRP,
                          initialData: _mrp)),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Quantity : ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: _buildTextField(
                          height: 40,
                          inputTextFieldType: _textFieldType.Quantity,
                          initialData: _quantity)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'In Stocks?',
                    style: TextStyle(fontSize: 24),
                  ), //Text
                  const SizedBox(width: 10), //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: _inStocks,
                    onChanged: (value) {
                      setState(() {
                        _inStocks = value!;
                      });
                    },
                  ), //Checkbox
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Cruelty Free ? ',
                    style: TextStyle(fontSize: 24),
                  ), //Text
                  const SizedBox(width: 10), //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: _crueltyFree,
                    onChanged: (value) {
                      setState(() {
                        _crueltyFree = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
