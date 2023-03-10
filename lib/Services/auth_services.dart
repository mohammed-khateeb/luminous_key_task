import 'package:flutter/services.dart';
import 'package:luminous_key_task/Models/Api/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AuthServices {

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'luminousKey_table';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnMobileNumber = 'mobile_number';

  static const columnPassword = 'password';

  Database? _db;

  Future<Database?> get db async{
    if(_db==null){
      _db = await init();
      return _db;
    }
    else{
      return _db;
    }
  }

  // this opens the database (and creates it if it doesn't exist)
   init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _db;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnMobileNumber TEXT NOT NULL
          )
          ''');
  }

  Future<User?> signUp(User user) async {
    Database? database = await db;

    final result = await database!.query(table,
        where: "$columnEmail = ?",
        whereArgs: [user.email],
        limit: 1);
    if(result.isNotEmpty)return null;
    int userId = await database.insert(table, user.toJson());
    user.id = userId;
    return user;
  }

  Future<User?> login(String email,String password)async{
    Database? database = await db;
      final result = await database!.query(table,
          where: "$columnEmail = ?  AND $columnPassword = ?",
          whereArgs: [email, password],
          limit: 1);
      if(result.isNotEmpty){
        User user = User.fromJson(result.first);
        return user;
      }
    return null;
  }

}