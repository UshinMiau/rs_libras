import 'package:sqflite/sqflite.dart';

class Connection {
  static Future<Database> getConnection() async {
    final String defaultConnection = await getDatabasesPath();
    const String dbName = "client.db";

    final String path = "$defaultConnection $dbName";

    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        const String sql = "create table clients(id INTEGER PRIMARY KEY AUTOINCREMENT, photoPath TEXT, name TEXT, lastName TEXT, email TEXT, password TEXT)";
        
        db.execute(sql);
      },
    );
    return db;
  }
}