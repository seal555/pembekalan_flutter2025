import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/repositories/db_repository.dart';

class InfoMahasiswaViewModel {
  InfoMahasiswaViewModel();

  // insert new data
  Future<int> insertDataMahasiswa(InfoMahasiswaModel model) async {
    return await DbRepository().insertDataMahasiswa(model);
  }

  // read all data
  Future<List<InfoMahasiswaModel>> readDataMahasiswa() async {
    return await DbRepository().readDataMahasiswa();
  }

  // update data by id
  Future<int> updateDataMahasiswa(InfoMahasiswaModel model) async {
    return await DbRepository().updateDataMahasiswa(model);
  }

  // read data by id
  Future<InfoMahasiswaModel> readDataMahasiswaById(int id) async {
    return await DbRepository().readDataMahasiswaById(id);
  }

  // search data by keyword
  Future<List<InfoMahasiswaModel>> searchDataMahasiswa(String keyword) async {
    return await DbRepository().searchDataMahasiswa(keyword);
  }

  // delete data
  Future<int> deleteDataMahasiswa(InfoMahasiswaModel model) async {
    return await DbRepository().deleteDataMahasiswa(model);
  }
}
