import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String? title, message, yes, no;
  final Color color = Colors.orangeAccent;
  final Function()? pressNo, pressYes;

  const CustomConfirmationDialog(
      {this.title,
      this.message,
      this.yes,
      this.no,
      this.pressYes,
      this.pressNo});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(title!),
      content: Text(message!),
      backgroundColor: color,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        TextButton(
            onPressed: pressNo,
            child: Text(
              no!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        TextButton(
            onPressed: pressYes,
            child: Text(
              yes!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
      ],
    );
  }
}
