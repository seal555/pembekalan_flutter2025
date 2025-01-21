import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_confirmationdialog.dart';
import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/viewmodels/info_mahasiswa_viewmodel.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailmahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/updatedatamahasiswascreen.dart';

class ListMahasiswaScreen extends StatefulWidget {
  const ListMahasiswaScreen({super.key});

  @override
  State<ListMahasiswaScreen> createState() => _ListMahasiswaScreenState();
}

class _ListMahasiswaScreenState extends State<ListMahasiswaScreen> {
  TextEditingController _keywordPencarian = new TextEditingController();

  List<InfoMahasiswaModel> _listMahasiswa = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // diawal tampilkan seluruh record dari tabel
    tampilkanListDataMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Mahasiswa'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.greenAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'List Mahasiswa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Keyword Pencarian',
                        suffixIcon: IconButton(
                            onPressed: () {
                              // jika button search di klik
                              cariDataMahasiswa();
                            },
                            icon: Icon(Icons.search))),
                    controller: _keywordPencarian,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: _listMahasiswa.length == 0
                  ? Text('Data tidak ditemukan')
                  : ListView.builder(
                      itemCount: _listMahasiswa.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              // aksinya
                              // pindah ke screen detail mahasiswa
                              InfoMahasiswaModel dataModel =
                                  _listMahasiswa[index];
                              pindahKeDetailMahasiswaScreen(dataModel);
                            },
                            child: Card(
                              color: index % 2 == 0
                                  ? Colors.white30
                                  : Colors.lightGreen,
                              margin: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: Image.file(
                                        File(_listMahasiswa[index].foto_path!),
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _listMahasiswa[index].nama!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _listMahasiswa[index].jurusan!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  // edit data
                                                  InfoMahasiswaModel dataModel =
                                                      _listMahasiswa[index];
                                                  pindahKeUpdateDataMahasiswaScreen(
                                                      dataModel);
                                                },
                                                icon: Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  // delete data
                                                  InfoMahasiswaModel dataModel =
                                                      _listMahasiswa[index];
                                                  konfirmasiDelete(dataModel);
                                                },
                                                icon:
                                                    Icon(Icons.delete_forever))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // pindah ke screen input data mahasiswa
          Navigator.pushNamed(context, Routes.inputdatamahasiswascreen)
              .then((value) {
            setState(() {
              // aksi saat terjadi callback
              tampilkanListDataMahasiswa();
            });
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'Tambah Data Mahasiswa',
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  void tampilkanListDataMahasiswa() async {
    await InfoMahasiswaViewModel().readDataMahasiswa().then((value) {
      setState(() {
        // tampilkan list data
        print('Jumlah record yang ditemukan = ${value.length}');
        _listMahasiswa = value;
      });
    });
  }

  void pindahKeDetailMahasiswaScreen(InfoMahasiswaModel dataModel) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailMahasiswaScreen(data: dataModel)))
        .then((value) {
      // refresh ulang tampilan list
      tampilkanListDataMahasiswa();
    });
  }

  void pindahKeUpdateDataMahasiswaScreen(InfoMahasiswaModel dataModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateDataMahasiswaScreen(data: dataModel))).then((value) {
      setState(() {
        // refresh ulang tampilan list
        tampilkanListDataMahasiswa();
      });
    });
  }

  void cariDataMahasiswa() async {
    // selama keyword tidak kosong
    if (_keywordPencarian.text.isEmpty) {
      // tampilkan ulang seluruh list
      tampilkanListDataMahasiswa();
    } else {
      // cari berdasarkan keyword yg diinput
      String keyword = _keywordPencarian.text;

      await InfoMahasiswaViewModel().searchDataMahasiswa(keyword).then((value) {
        setState(() {
          print('Hasil Pencarian = ${value.length}');
          //update listMahasiswa
          _listMahasiswa = value;
        });
      });
    }
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

        // refresh list
        tampilkanListDataMahasiswa();
      });
    });
  }
}
