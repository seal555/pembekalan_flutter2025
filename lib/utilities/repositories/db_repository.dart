import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DbRepository {
  //CRUD
  DatabaseHelper databaseHelper = new DatabaseHelper();

  // insert data mahasiswa
  Future<int> insertDataMahasiswa(InfoMahasiswaModel model) async {
    final Database db = await databaseHelper.initDatabase();

    final result = await db.insert(databaseHelper.tableName, model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }

  // read all data
  Future<List<InfoMahasiswaModel>> readDataMahasiswa() async{
    final Database db = await databaseHelper.initDatabase();

    final List<Map<String, dynamic>> datas = await db.query(databaseHelper.tableName);

    List<InfoMahasiswaModel> result = List.generate(datas.length, (index){
      return InfoMahasiswaModel.fromMap(datas[index]);
    });

    return result;
  }
}
