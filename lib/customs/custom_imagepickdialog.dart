import 'package:flutter/material.dart';

Widget customImagePickDialog({
  void Function()? onCameraPressed,
  void Function()? onGalleryPressed,
}) {
  return AlertDialog(
    title: Text('Pilih sumber image : '),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Camera'),
          onTap: onCameraPressed,
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Gallery'),
          onTap: onGalleryPressed,
        )
      ],
    ),
  );
}
