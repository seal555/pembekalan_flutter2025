import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/viewmodels/info_mahasiswa_viewmodel.dart';

class InputDataMahasiswaScreen extends StatefulWidget {
  const InputDataMahasiswaScreen({super.key});

  @override
  State<InputDataMahasiswaScreen> createState() =>
      _InputDataMahasiswaScreenState();
}

class _InputDataMahasiswaScreenState extends State<InputDataMahasiswaScreen> {
  TextEditingController _namaController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _alamatController = new TextEditingController();
  TextEditingController _jurusanController = new TextEditingController();

  String _tanggalLahir = '';
  File? _image;
  String _fotoPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Mahasiswa'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.greenAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Input Nama Lengkap'),
                maxLength: 50,
                controller: _namaController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pilih Tanggal Lahir (dd/MM/yyyy) '),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // munculkan date picker
                            pilihTanggalLahir();
                          },
                          icon: Icon(Icons.calendar_month)),
                      Text(
                        '$_tanggalLahir',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Gender (L/P)'),
                maxLength: 1,
                controller: _genderController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Alamat Lengkap'),
                maxLength: 200,
                controller: _alamatController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Jurusan'),
                maxLength: 30,
                controller: _jurusanController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    // panggil camera
                    getImageFromCamera();
                  },
                  child: _image == null
                      ? Image.asset(
                          'assets/images/logo_xa.png',
                          width: 100,
                          height: 100,
                        )
                      : Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                // validasi input
                validasiInput();
              },
              child: Text(
                'Simpan Data',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green)),
            )
          ],
        ),
      ),
    );
  }

  void pilihTanggalLahir() async {
    final DateTime? picker = await showDatePicker(
        context: context,
        firstDate: DateTime(1945),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());

    if (picker != null) {
      setState(() {
        _tanggalLahir = DateFormat('dd/MM/yyyy').format(picker);
      });
    }
  }

  void getImageFromCamera() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _fotoPath = pickedImage.path;

        print("Path Image = ${pickedImage.path}");
      }
    });
  }

  void validasiInput() {
    if (_namaController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar('Nama Lengkap harus diisi!'));
    }
    else if(_tanggalLahir.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar('Tanggal Lahir belum dipilih!'));
    }
    else if(_genderController.text.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar('Gender harus diisi! (L/P)'));
    }
    else if(_alamatController.text.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar('Alamat Lengkap harus diisi!'));
    }
    else if(_jurusanController.text.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar('Jurusan harus diisi!'));
    }
    else if(_image == null && _fotoPath.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar('Foto profil belum dipilih!'));
    }
    else{
      // simpan ke database
      simpanDataMahasiswa();
    }
  }

  void simpanDataMahasiswa() async {
    InfoMahasiswaModel model = new InfoMahasiswaModel(
      nama: _namaController.text,
      tanggal_lahir: _tanggalLahir,
      gender: _genderController.text,
      alamat: _alamatController.text,
      jurusan: _jurusanController.text,
      foto_path: _fotoPath
    );

    await InfoMahasiswaViewModel().insertDataMahasiswa(model).then((value){
      print('Response Database : $value');
      clearAllInputs();
    });
  }

  void clearAllInputs(){
    setState(() {
      _namaController.text = '';
      _tanggalLahir = '';
      _genderController.text = '';
      _alamatController.text = '';
      _jurusanController.text = '';
      _fotoPath = '';
      _image = null;
    });
  }
}
