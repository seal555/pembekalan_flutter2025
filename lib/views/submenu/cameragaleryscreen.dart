import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraGaleryScreen extends StatefulWidget {
  const CameraGaleryScreen({super.key});

  @override
  State<CameraGaleryScreen> createState() => _CameraGaleryScreenState();
}

class _CameraGaleryScreenState extends State<CameraGaleryScreen> {
  File? _image;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera & Galery'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _image == null ? Text('No image selected') : Image.file(_image!),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                getImageFromGalery();
              },
              child: Icon(
                Icons.photo_album,
                color: Colors.white,
              ),
              backgroundColor: Colors.redAccent,
              heroTag: null, //fixing issue 'There are multiple heroes that share the same tag within a subtree.'
            ),
            FloatingActionButton(
              onPressed: () {
                // ambil image dari camera
                getImageFromCamera();
              },
              child: Icon(
                Icons.camera,
                color: Colors.white,
              ),
              backgroundColor: Colors.redAccent,
              heroTag: null,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future getImageFromCamera() async {
    XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        requestFullMetadata: true);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected from Camera');
      }
    });

    /*
    TODO: explore cara save image otomatis ke memory hp
    untuk Android >= 13
    */
  }

  Future getImageFromGalery() async {
    XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        requestFullMetadata: true);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected from Gallery');
      }
    });
  }
}
