import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/models/list_users_model.dart';
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
  Future<List<InfoMahasiswaModel>> readDataMahasiswa() async {
    final Database db = await databaseHelper.initDatabase();

    final List<Map<String, dynamic>> datas =
        await db.query(databaseHelper.tableName);

    List<InfoMahasiswaModel> result = List.generate(datas.length, (index) {
      return InfoMahasiswaModel.fromMap(datas[index]);
    });

    return result;
  }

  // update data
  Future<int> updateDataMahasiswa(InfoMahasiswaModel model) async {
    final Database db = await databaseHelper.initDatabase();

    final result = await db.update(databaseHelper.tableName, model.toMap(),
        // parameter kondisi
        where: 'id = ?',
        // valuenya
        whereArgs: [model.id],
        conflictAlgorithm: ConflictAlgorithm.fail);

    return result;
  }

  // read data by id
  Future<InfoMahasiswaModel> readDataMahasiswaById(int id) async {
    final Database db = await databaseHelper.initDatabase();

    final List<Map<String, dynamic>> datas = await db
        .query(databaseHelper.tableName, where: 'id = ?', whereArgs: [id]);

    List<InfoMahasiswaModel> result = List.generate(datas.length, (index) {
      return InfoMahasiswaModel.fromMap(datas[index]);
    });

    return result.elementAt(0);
  }

  // search data by keyword = nama
  Future<List<InfoMahasiswaModel>> searchDataMahasiswa(String keyword) async {
    final Database db = await databaseHelper.initDatabase();

    // raw query
    String rawQuery =
        'SELECT * FROM ${databaseHelper.tableName} WHERE nama like "%$keyword%"';

    final List<Map<String, dynamic>> datas = await db.rawQuery(rawQuery);

    final result = List.generate(datas.length, (index) {
      //konversi dari Map menjadi model
      return InfoMahasiswaModel.fromMap(datas[index]);
    });

    return result;
  }

  // delete data by id
  Future<int> deleteDataMahasiswa(InfoMahasiswaModel model) async {
    final Database db = await databaseHelper.initDatabase();

    print('ID yg akan di delete = ${model.id}');

    final result = await db.delete(databaseHelper.tableName,
        // parameter kondisi
        where: 'id = ?', 
        // value
        whereArgs: [model.id]);

    return result;    
  }
}
