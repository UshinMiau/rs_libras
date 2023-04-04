import 'package:rs_libras/model/DAO/connection.dart';
import 'package:rs_libras/model/client.dart';
import 'package:sqflite/sqflite.dart';

class ClientDAO {
  static const String _table = "clients";

  static Future<int> insert(Map<String, dynamic> map) async {
    Database database = await Connection.getConnection();

    int result = await database.insert(_table, map);

    return result;
  }

  static Future<int> update(Map<String, dynamic> map) async {
    Database database = await Connection.getConnection();

    int result = await database.update(
      _table,
      map,
      where: "id = ?",
      whereArgs: [map["id"]],
    );

    return result;
  }

  static Future<Client?> getClientByEmailAndPassword(
    String email, String password) async {
    Database database = await Connection.getConnection();

    final maps = await database.query(
      _table,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    print(maps.toString());

    if (maps.isNotEmpty) {
      return Client.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Client>> findAll() async {
    Database database = await Connection.getConnection();

    final maps = await database.query(_table, orderBy: "name asc");

    return maps.map((item) => Client.fromMap(item)).toList();
  }

  static Future<int> delete(int id) async {
    Database database = await Connection.getConnection();

    int result = await database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }
}
