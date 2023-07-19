import 'package:job_finder/controller/utils/shared_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'tables_columns_titles.dart';

class SqlHelper {
  static late Database sqlDb;
  static late String databasePath;

  static void saveToShared() async {
    await SharedHelper.saveData(
        key: SharedHelper.databasePathKey, value: databasePath);
  }

  static Future<bool> tableHasData({required String table}) async {
    return Sqflite.firstIntValue(
            await sqlDb.rawQuery('SELECT COUNT(*) FROM $table')) !=
        0;
  }

  static void init() async {
    // step 1: create database file
    databasePath = join(await getDatabasesPath(), 'job_finder.db');
    // step 2: open database and create table
    await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        sqlDb = db;
        saveToShared();
        db.execute(''' 
        CREATE TABLE ${UserTableColumnTitles.usersTable}(
          ${UserTableColumnTitles.id} INTEGER PRIMARY KEY, ${UserTableColumnTitles.name} TEXT NOT NULL, ${UserTableColumnTitles.email} TEXT NOT NULL, 
          ${UserTableColumnTitles.otp} INTEGER NULL, ${UserTableColumnTitles.token} TEXT NOT NULL, ${UserTableColumnTitles.towStep} TEXT NULL, 
          ${UserTableColumnTitles.emailVerifiedAt} TEXT NULL, ${UserTableColumnTitles.createdAt} TEXT NULL,
          ${UserTableColumnTitles.updatedAt} TEXT NULL, ${UserTableColumnTitles.careerType} TEXT NULL, ${UserTableColumnTitles.workNature} TEXT NULL,
          ${UserTableColumnTitles.workLocations} TEXT NULL, ${UserTableColumnTitles.login} INTEGER NOT NULL
        );
        ''');

        // db.execute('''
        //   CREATE TABLE Job (
        //     id integer primary key,
        //     title text not null,
        //     description text not null,
        //     company text not null,
        //     location text not null,
        //     salary text not null,
        //     type text not null,
        //     created_at text not null,
        //     updated_at text not null,
        //     user_id integer not null,
        //   );
        // ''');
      },
    );
  }

  /// CRUD operation as function
  /// for people who not are familiar with SQL
  static Future<int> insertRowAsMap({
    required String table,
    required Map<String, Object?> values,
  }) async {
    return await sqlDb.insert(
      table,
      values,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllRows({
    required String table,
  }) async {
    return await sqlDb.query(table);
  }

  static Future<int> updateRowAsMap({
    required String table,
    required Map<String, Object> values,
  }) async {
    return await sqlDb.update(
      table,
      values,
    );
  }

  static Future<int> deleteAllRows({
    required String table,
  }) async {
    return await sqlDb.delete(
      table,
    );
  }

  /// CRUD operation as SQL statement
  ///
  /// for people who are familiar with SQL
  static Future<int> insertData({required String queryStatement}) async {
    return await sqlDb.rawInsert(queryStatement);
  }

  static Future<List<Map<String, dynamic>>> queryData(
      {required String queryStatement}) async {
    return await sqlDb.rawQuery(queryStatement);
  }

  static Future<int> updateData({required String queryStatement}) async {
    return await sqlDb.rawUpdate(queryStatement);
  }

  static Future<int> deleteData({required String queryStatement}) async {
    return await sqlDb.rawDelete(queryStatement);
  }

  //! ..................................................... !//
}
