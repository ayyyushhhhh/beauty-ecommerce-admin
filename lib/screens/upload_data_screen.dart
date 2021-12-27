import 'package:beauty_app/models/product_model.dart';
import 'package:beauty_app/services/firebase/cloud_database.dart';
import 'package:beauty_app/widgets/file_upload_button.dart';
import 'package:flutter/material.dart';

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
  const UploadDataScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Data"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FileUploadArea(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Name, height: 50),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Description",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.ProductDescription,
                  height: 200),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "MRP : ₹",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: _buildTextField(
                          height: 40, inputTextFieldType: _textFieldType.MRP)),
                  SizedBox(width: 10),
                  Text(
                    "Quantity : ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: _buildTextField(
                          height: 40,
                          inputTextFieldType: _textFieldType.Quantity)),
                  SizedBox(width: 10),
                  Row(
                    children: [
                      Text(
                        'In Stocks?',
                        style: TextStyle(fontSize: 24),
                      ), //Text
                      SizedBox(width: 10), //SizedBox
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
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cruelty Free ? ',
                        style: TextStyle(fontSize: 24),
                      ), //Text
                      SizedBox(width: 10), //SizedBox
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
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Features",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Features, height: 200),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Benefits",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Benefits, height: 200),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.Ingredients, height: 200),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Country of Origin",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.CountryOfOrigin,
                  height: 50),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Importer Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.NameOfImporter,
                  height: 100),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Address Importer",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  inputTextFieldType: _textFieldType.ImporterAddress,
                  height: 100),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final ProductModel productModel = ProductModel(
                      images: [],
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
                  final CloudDatabase cloudDatabase = CloudDatabase();
                  cloudDatabase.uploadProductData(productModel.toMap());
                },
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required double height,
    required _textFieldType inputTextFieldType,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      // margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        expands: true,
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
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
