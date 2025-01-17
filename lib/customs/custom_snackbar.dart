import 'package:flutter/material.dart';

SnackBar customSnackbar(String message) => SnackBar(
      content:
          Text(message, style: TextStyle(color: Colors.white, fontSize: 16)),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.orangeAccent,
    );
