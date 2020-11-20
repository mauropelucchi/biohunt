import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';

/// This is the singleton database class which handlers all database transactions
/// All the tappa raw queries is handle here and return a Future<T> with result
class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  //private internal constructor to make it singleton
  AppDatabase._internal();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tappe.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await _createPercorsoTable(db);
      await _createTappaTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${Tappe.tblTappa}");
      await db.execute("DROP TABLE ${Percorso.tblPercorso}");
      await _createPercorsoTable(db);
      await _createTappaTable(db);
    });
    didInit = true;
  }

  Future _createPercorsoTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Percorso.tblPercorso} ("
          "${Percorso.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Percorso.dbName} TEXT,"
          "${Percorso.dbColorName} TEXT,"
          "${Percorso.dbColorCode} INTEGER);");
      txn.rawInsert('INSERT INTO '
          '${Percorso.tblPercorso}(${Percorso.dbId},${Percorso.dbName},${Percorso.dbColorName},${Percorso.dbColorCode})'
          ' VALUES(1, "Fontanella", "Grey", ${Colors.grey.value});');
      txn.rawInsert('INSERT INTO '
          '${Percorso.tblPercorso}(${Percorso.dbId},${Percorso.dbName},${Percorso.dbColorName},${Percorso.dbColorCode})'
          ' VALUES(2, "San Giovanni", "Grey", ${Colors.grey.value});');
    });
  }

  Future _createTappaTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Tappe.tblTappa} ("
        "${Tappe.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Tappe.dbTitle} TEXT,"
        "${Tappe.dbDescription} TEXT,"
        "${Tappe.dbImage} TEXT,"
        "${Tappe.dbLat} DECIMAL,"
        "${Tappe.dbLng} DECIMAL,"
        "${Tappe.dbPercorsoID} LONG,"
        "${Tappe.dbStatus} LONG,"
        "${Tappe.dbLastTappa} BOOLEAN,"
        "FOREIGN KEY(${Tappe.dbPercorsoID}) REFERENCES ${Percorso.tblPercorso}(${Percorso.dbId}) ON DELETE CASCADE);");
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1, "Partenza", 45.716147, 9.505728, 1, 0, FALSE,'
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis nunc eu eros iaculis tincidunt. Vestibulum placerat, nunc et auctor facilisis, quam orci molestie quam, non euismod turpis risus laoreet magna.",'
          '"assets/montecanto.jpg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2, "Muro", 45.716147, 9.505728, 1, 0, FALSE,'
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis nunc eu eros iaculis tincidunt. Vestibulum placerat, nunc et auctor facilisis, quam orci molestie quam, non euismod turpis risus laoreet magna.",'
          '"assets/montecanto.jpg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(3, "Bravo!", 45.716147, 9.505728, 1, 0, TRUE,'
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis nunc eu eros iaculis tincidunt. Vestibulum placerat, nunc et auctor facilisis, quam orci molestie quam, non euismod turpis risus laoreet magna.",'
          '"assets/montecanto.jpg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(4, "Partenza", 45.716147, 9.505728, 2, 0, FALSE,'
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis nunc eu eros iaculis tincidunt. Vestibulum placerat, nunc et auctor facilisis, quam orci molestie quam, non euismod turpis risus laoreet magna.",'
          '"assets/montecanto.jpg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(5, "Torre", 45.716147, 9.505728, 2, 0, FALSE,'
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis nunc eu eros iaculis tincidunt. Vestibulum placerat, nunc et auctor facilisis, quam orci molestie quam, non euismod turpis risus laoreet magna.",'
          '"assets/montecanto.jpg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(6, "Bravo!", 45.716147, 9.505728, 2, 0, TRUE,'
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis nunc eu eros iaculis tincidunt. Vestibulum placerat, nunc et auctor facilisis, quam orci molestie quam, non euismod turpis risus laoreet magna.",'
          '"assets/montecanto.jpg"'
          ');');
    });
  }
}
