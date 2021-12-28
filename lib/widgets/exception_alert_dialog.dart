import 'dart:io';

import 'package:beauty_app/widgets/error_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception).toString(),
      defaultActionText: 'OK',
    );

String? _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  } else if (exception is PlatformException || exception is SocketException) {
    return "Please, Connect to the Internet";
  }
  return "Please try Again after some time";
}
