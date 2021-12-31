// ignore_for_file: constant_identifier_names

import 'dart:convert';
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
  // ignore: prefer_final_fields
  late List<String> _images = [];
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
  ZefyrController _productDescriptionController = ZefyrController();
  ZefyrController _featuresController = ZefyrController();
  ZefyrController _benefitsController = ZefyrController();
  ZefyrController _ingredientsController = ZefyrController();
  List<String> _previewImages = [];
  String _productCatergory = "Skincare";
  final List<String> _dropDownItems = [
    "Skincare",
    "Makeup",
    "Anti-Aging",
    "Skin Protection",
    "Hair Care",
    "Personal Care",
  ];
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
      _featuresController = ZefyrController(
        NotusDocument.fromJson(jsonDecode(widget.product!.features)),
      );
      _benefitsController = ZefyrController(
        NotusDocument.fromJson(jsonDecode(widget.product!.benefits)),
      );
      _ingredientsController = ZefyrController(
        NotusDocument.fromJson(jsonDecode(widget.product!.ingredients)),
      );
      _productDescriptionController = ZefyrController(
        NotusDocument.fromJson(jsonDecode(widget.product!.productDescription)),
      );
      _inStocks = widget.product!.inStocks;
      _crueltyFree = widget.product!.crueltyFree;
      _countryofOrigin = widget.product!.countryofOrigin;
      _nameOfImporter = widget.product!.nameOfImporter;
      _addressofImporter = widget.product!.addressofImporter;
      _previewImages = widget.product!.images;
      _images = widget.product!.images;
      _productCatergory = widget.product!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Upload Product",
      color: Colors.black,
      child: Scaffold(
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
                  imagePaths: _previewImages,
                  onCountChanged: (String? imageurl, int? index) {
                    if (imageurl != null) {
                      _images.add(imageurl);
                    } else {
                      _images.removeAt(index!);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                    value: _productCatergory,
                    items: _dropDownItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          _productCatergory = value;
                        }
                      });
                    }),
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
                _buildZefrkaTextField(
                  controller: _productDescriptionController,
                  height: 200,
                  focusNode: FocusNode(),
                ),
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
                _buildZefrkaTextField(
                  controller: _featuresController,
                  focusNode: FocusNode(),
                  height: 200,
                ),
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
                _buildZefrkaTextField(
                  controller: _benefitsController,
                  focusNode: FocusNode(),
                  height: 200,
                ),
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
                _buildZefrkaTextField(
                  controller: _ingredientsController,
                  focusNode: FocusNode(),
                  height: 200,
                ),
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
                    _productDescription =
                        jsonEncode(_productDescriptionController.document);
                    _features = jsonEncode(_featuresController.document);
                    _benefits = jsonEncode(_featuresController.document);
                    _ingredients = jsonEncode(_ingredientsController.document);
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
      addressofImporter: _addressofImporter,
      category: _productCatergory,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          product: product,
        ),
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

  Widget _buildZefrkaTextField({
    required double height,
    required ZefyrController controller,
    required FocusNode focusNode,
  }) {
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Container(
        width: double.infinity,
        height: 1.5 * height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            ZefyrToolbar.basic(
              controller: controller,
            ),
            const Divider(
              thickness: 1,
            ),
            ZefyrEditor(
              focusNode: focusNode,
              maxHeight: height,
              scrollable: true,
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }

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
