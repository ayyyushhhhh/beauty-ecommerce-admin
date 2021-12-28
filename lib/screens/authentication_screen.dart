import 'package:beauty_app/screens/upload_data_screen.dart';
import 'package:beauty_app/services/firebase/firebase_auth.dart';
import 'package:beauty_app/widgets/exception_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 400,
              height: 50,
              child: TextField(
                maxLines: 1,
                onChanged: (value) {
                  _email = value;
                },
                decoration: InputDecoration(
                  label: Text('Email Address'),
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
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            height: 50,
            child: TextField(
              maxLines: 1,
              onChanged: (value) {
                _password = value;
              },
              decoration: InputDecoration(
                label: Text('Password'),
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
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_email != null && _password != null) {
                try {
                  User? user = await FirebaseAuthentication()
                      .signInWithEmailAndPassword(
                          email: _email.toString(),
                          password: _password.toString());
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadDataScreen()),
                    );
                  }
                } on FirebaseException catch (e) {
                  showExceptionAlertDialog(context,
                      exception: e, title: "Login Failed");
                }
              }
            },
            child: Container(
              height: 70,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Login",
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
    );
  }
}
