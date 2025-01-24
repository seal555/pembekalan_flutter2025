import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pembekalan_flutter/customs/custom_imagepickdialog.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
import 'package:pembekalan_flutter/models/recognition_response_model.dart';
import 'package:pembekalan_flutter/utilities/recognizer/mlkit_text_recognizer.dart';
import 'package:pembekalan_flutter/utilities/recognizer/text_recognizer.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;
  RecognitionResponseModel? _response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _picker = ImagePicker();
    _recognizer = MLKitTextRecognizer();
    // _recognizer = TesseractTextRecognizer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
  }

  void processImage(String _imgPath) async {
    final _recognizedText = await _recognizer.processImage(_imgPath);
    setState(() {
      _response = RecognitionResponseModel(
          imgPath: _imgPath, recognizedText: _recognizedText);
    });
  }

  Future<String?> obtainImage(ImageSource _source) async {
    final file = await _picker.pickImage(source: _source);
    return file?.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OCR Screen'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _response == null
            ? Text('Pilih image terlebih dahulu!')
            : ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(File(_response!.imgPath)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Recognized Text',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  // fungsi copy text
                                  Clipboard.setData(ClipboardData(
                                      text: _response!.recognizedText));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackbar(
                                          'Text Copied to Clipboard!'));
                                },
                                icon: Icon(Icons.copy)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _response!.recognizedText,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // tampilkan dialog pilihan
          showDialog(
              context: context,
              builder: (context) => customImagePickDialog(
                    onCameraPressed: () async {
                      //camera
                      final imgPath = await obtainImage(ImageSource.camera);
                      if (imgPath == null) return;
                      Navigator.of(context).pop();
                      processImage(imgPath);
                    },
                    onGalleryPressed: () async {
                      //gallery
                      final imgPath = await obtainImage(ImageSource.gallery);
                      if (imgPath == null) return;
                      Navigator.of(context).pop();
                      processImage(imgPath);
                    },
                  ));
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
