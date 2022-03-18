import 'package:beauty_app/models/routes_class.dart';
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
    return Title(
      title: "Makdeck Login",
      color: Colors.black,
      child: Scaffold(
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
                    label: const Text('Email Address'),
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 400,
              height: 50,
              child: TextField(
                maxLines: 1,
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                decoration: InputDecoration(
                  label: const Text('Password'),
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
            ),
            const SizedBox(
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
                      Navigator.popAndPushNamed(context, Routes().allProducts);
                      // Navigator.pushReplacementNamed(
                      //   context,
                      //   Routes().allProducts,
                      // );
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
                decoration: const BoxDecoration(
                  color: Colors.purple,
                ),
                child: const Align(
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
      ),
    );
  }
}
