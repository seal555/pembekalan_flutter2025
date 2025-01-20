import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';

class ListMahasiswaScreen extends StatefulWidget {
  const ListMahasiswaScreen({super.key});

  @override
  State<ListMahasiswaScreen> createState() => _ListMahasiswaScreenState();
}

class _ListMahasiswaScreenState extends State<ListMahasiswaScreen> {
  TextEditingController _keywordPencarian = new TextEditingController();

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
          Expanded(child: Text('Data tidak ditemukan'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // pindah ke screen input data mahasiswa
          Navigator.pushNamed(context, Routes.inputdatamahasiswascreen).then((value){
            setState(() {
              // aksi saat terjadi callback
              // ???
            });
          });
        },
        child: Icon(Icons.add, color: Colors.white,),
        tooltip: 'Tambah Data Mahasiswa',
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}
