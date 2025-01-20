import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/repositories/db_repository.dart';

class InfoMahasiswaViewModel {
  InfoMahasiswaViewModel();

  // insert new data
  Future<int> insertDataMahasiswa(InfoMahasiswaModel model) async {
    return await DbRepository().insertDataMahasiswa(model);
  }

  // read data
  Future<List<InfoMahasiswaModel>> readDataMahasiswa() async{
    return await DbRepository().readDataMahasiswa();
  }

}