import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppAlert {
  static getAlert( String? title, String message, onPressed) {
    return  Get.defaultDialog(
        title: title??"INFO",
        textConfirm: 'OK',
        buttonColor: Colors.blue,
        confirmTextColor: Colors.white,
        onConfirm: onPressed,
        content: Text(message),
    );
  }
  static getAlertHapus( String? id,String? title, String message, onPressed) {
    return  Get.defaultDialog(
        title: title??"INFO",
        textConfirm: 'Hapus',
        textCancel: 'Close',
        buttonColor: Colors.red,
        confirmTextColor: Colors.white,
        onConfirm: onPressed,
        content: Text(message),
    );
  }
  static loading( String? title, String message) {
    return  Get.defaultDialog(
      barrierDismissible: false,
        title: title??"INFO",
        content: Column(
          children: [
            CircularProgressIndicator(),
            Text(message),
          ],
        ),
    );
  }
}