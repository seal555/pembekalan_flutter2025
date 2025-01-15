import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? action_text;
  final Color bgcolor = Colors.redAccent;

  const CustomAlertDialog({this.title, this.message, this.action_text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(title!),
      content: Text(message!),
      backgroundColor: bgcolor,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              action_text!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
      ],
    );
  }
}
