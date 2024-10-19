import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG, // Toast duration: LENGTH_SHORT or LENGTH_LONG
    gravity: ToastGravity.BOTTOM, // Toast position: TOP, BOTTOM, CENTER
    timeInSecForIosWeb: 1, // For iOS
    backgroundColor: Colors.black54, // Toast background color
    textColor: Colors.white, // Text color
    fontSize: 16.0, // Font size
  );
}