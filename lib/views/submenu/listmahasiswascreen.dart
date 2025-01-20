import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/viewmodels/info_mahasiswa_viewmodel.dart';

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
                                                },
                                                icon: Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  // delete data
                                                },
                                                icon: Icon(Icons.delete_forever))
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
}
