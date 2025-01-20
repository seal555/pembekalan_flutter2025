import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String databaseName = 'info_mahasiswa.db';
  String tableName = 'profil_mahasiswa';

  // init database
  Future<Database> initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), '$databaseName'),
        // versi database defailt = 1, jika ada update, tinggal naikan angkanya
        version: 1,
        // operasi yg pertama kali dilakukan, saat terkoneksi dng database
        onCreate: createTable);
  }

  // create table (hanya dilakukan jika belum ada)
  //  gunakan tools bantuan https://sqlitebrowser.org/
  void createTable(Database db, int version) async {
    String syntaxQuery = '''CREATE TABLE "$tableName" (
      "id"	INTEGER,
      "nama"	TEXT,
      "tanggal_lahir"	TEXT,
      "gender"	TEXT,
      "alamat"	TEXT,
      "jurusan"	TEXT,
      "foto_path"	TEXT,
      PRIMARY KEY("id" AUTOINCREMENT)
    );''';

    await db.execute(syntaxQuery);
  }
}
