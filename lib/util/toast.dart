// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void show(
    String message,
    BuildContext context,
  ) {
    Fluttertoast.showToast(
        msg: "$message",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
