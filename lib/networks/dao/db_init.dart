import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../db_table_constants.dart';

final class DbSingleton {
  static final DbSingleton _singleton = DbSingleton._internal();
  DbSingleton._internal();
  static DbSingleton get instance => _singleton;

  static const databaseVersion = 1;
  static const _databaseName = 'com.weather.data';
  late Database db;

  Future<Database> create() async {
    db = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createMoviesTableV1(batch);
        await batch.commit();
      },
      version: databaseVersion,
    );
    return db;
  }

  void _createMoviesTableV1(Batch batch) {
    batch.execute('''
       create TABLE ${TableConst.kForcastTableName}
       (
       ${TableConst.kId} TEXT PRIMARY KEY,
       ${TableConst.kTitle} TEXT,
       ${TableConst.kThumbnail} TEXT,
       ${TableConst.kUserId} TEXT
       )
       ''');
    batch.execute('''
       create TABLE  ${TableConst.kCurrentTableName}
       (
        ${TableConst.kId} TEXT PRIMARY KEY,
        ${TableConst.kUrl} TEXT, 
        ${TableConst.kTitle} TEXT,
        ${TableConst.kContent} TEXT,
        ${TableConst.kImage} TEXT,
        ${TableConst.kThumbnail} TEXT,
        ${TableConst.kUserId} TEXT
       )
       ''');
  }
}

Future<int> saveData(String table, Map<String, Object?> data) =>
    DbSingleton.instance.db
        .insert(table, data, conflictAlgorithm: ConflictAlgorithm.fail);

Future<List<Map<String, dynamic>>> getAllData(String table,
        [int? limit, int? offset]) =>
    DbSingleton.instance.db.query(table, limit: limit, offset: offset);

Future<List<Map<String, dynamic>>> getDataByID(
        {required String table, required String where, required String id}) =>
    DbSingleton.instance.db.query(table, where: where, whereArgs: [id]);

Future<List<Map<String, dynamic>>> queryString(String query) =>
    DbSingleton.instance.db.rawQuery(query);

Future<int> deleteData(
        {required String table, required String where, required String id}) =>
    DbSingleton.instance.db.delete(table, where: where, whereArgs: [id]);

Future<void> insertBatchData(
        {required String table, required List<dynamic> entities}) =>
    DbSingleton.instance.db.transaction(
      (txn) async {
        for (final entity in entities) {
          txn.insert(table, entity.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      },
    );
