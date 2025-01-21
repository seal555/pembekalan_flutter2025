import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_confirmationdialog.dart';
import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/viewmodels/info_mahasiswa_viewmodel.dart';
import 'package:pembekalan_flutter/views/submenu/updatedatamahasiswascreen.dart';

class DetailMahasiswaScreen extends StatefulWidget {
  // untuk handle data yg dikirim dari pemanggilnya
  final InfoMahasiswaModel? data;

  DetailMahasiswaScreen({this.data});

  @override
  State<DetailMahasiswaScreen> createState() => _DetailmahasiswascreenState();
}

class _DetailmahasiswascreenState extends State<DetailMahasiswaScreen> {
  File? image;
  String? nama, tanggal_lahir, gender, alamat, jurusan;
  int? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setInitValue(widget.data!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mahasiswa'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.greenAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: image == null
                  ? Image.asset(
                      'assets/images/logo_xa.png',
                      width: 250,
                      height: 250,
                    )
                  : Image.file(
                      image!,
                      width: 250,
                      height: 250,
                    ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Nama Lengkap : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$nama',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Tanggal Lahir : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$tanggal_lahir',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Gender : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$gender',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Alamat : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$alamat',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Jurusan : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$jurusan',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {
                      // edit data
                      pindahKeUpdateDataMahasiswaScreen(widget.data!);
                    }, icon: Icon(Icons.edit)),
                    SizedBox(width: 50,),
                    IconButton(
                        onPressed: () {
                          // delete data
                            konfirmasiDelete(widget.data!);
                        }, icon: Icon(Icons.delete_forever)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void pindahKeUpdateDataMahasiswaScreen(InfoMahasiswaModel dataModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateDataMahasiswaScreen(data: dataModel))).then((value){
              // refresh tampilan
              readUlangData();
            });
  }

   void readUlangData() async{
    await InfoMahasiswaViewModel().readDataMahasiswaById(id!).then((value){
      print('Response Read Ulang = $value');
      setState(() {
        setInitValue(value);
      });
    });
   }

   void setInitValue(InfoMahasiswaModel model){
    image = File(model.foto_path!);
    nama = model.nama;
    tanggal_lahir = model.tanggal_lahir;
    gender = model.gender;
    alamat = model.alamat;
    jurusan = widget.data!.jurusan;
    id = model.id;
   }

   void konfirmasiDelete(InfoMahasiswaModel dataModel) async {
    var confirmationDialog = CustomConfirmationDialog(
      title: 'Hapus Data',
      message: 'Yakin ingin menghapus data ini?',
      yes: 'Ya',
      no: 'Tidak',
      pressYes: (){
        // jadi delete
        hapusDataMahasiswa(dataModel);
        Navigator.of(context).pop();
      },
      pressNo: (){
        // tidak jadi delete
        Navigator.of(context).pop();
      },
    );

    showDialog(context: context, builder: (_) => confirmationDialog);
  }

  void hapusDataMahasiswa(InfoMahasiswaModel dataModel) async {
    await InfoMahasiswaViewModel().deleteDataMahasiswa(dataModel).then((value){
      setState(() {
        print('Jumlah record yang terpengaruh = $value');

        // kembali ke list mahasiswa screen
        Navigator.of(context).pop();
      });
    });
  }
}
