import 'dart:convert';

class InfoMahasiswaModel {
  /*
  jika generate getter & setter tidak muncul di VSCode
  install plugin 'Dart Data Class Generator'
  CTRL + ., pilih generate data class
  */

  int? id;
  String? nama;
  String? tanggal_lahir;
  String? gender;
  String? alamat;
  String? jurusan;
  String? foto_path;

  InfoMahasiswaModel({
    this.id,
    this.nama,
    this.tanggal_lahir,
    this.gender,
    this.alamat,
    this.jurusan,
    this.foto_path,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(nama != null){
      result.addAll({'nama': nama});
    }
    if(tanggal_lahir != null){
      result.addAll({'tanggal_lahir': tanggal_lahir});
    }
    if(gender != null){
      result.addAll({'gender': gender});
    }
    if(alamat != null){
      result.addAll({'alamat': alamat});
    }
    if(jurusan != null){
      result.addAll({'jurusan': jurusan});
    }
    if(foto_path != null){
      result.addAll({'foto_path': foto_path});
    }
  
    return result;
  }

  factory InfoMahasiswaModel.fromMap(Map<String, dynamic> map) {
    return InfoMahasiswaModel(
      id: map['id']?.toInt(),
      nama: map['nama'],
      tanggal_lahir: map['tanggal_lahir'],
      gender: map['gender'],
      alamat: map['alamat'],
      jurusan: map['jurusan'],
      foto_path: map['foto_path'],
    );
  }
}
