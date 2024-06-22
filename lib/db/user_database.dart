import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const userTable = 'userTable';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future <Database> get database async {
    if (_database != null){
      return _database!;
    }
    _database = await createDatabase();
    return _database!;
  }

  createDatabase() async {
    String path = '/assets/db/User.db';
    // sqfliteFfiInit();
    if(kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else{
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      path = p.join(documentsDirectory.path, "User.db");
    }

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  void onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ){
    if (newVersion > oldVersion){}
  }

  void initDB(Database database, int version) async {
    await database.execute(
      "CREATE TABLE $userTable ("
      "id INTEGER PRIMARY KEY, "
      "username TEXT, "
      "token TEXT "
      ")"
    );
  }
}