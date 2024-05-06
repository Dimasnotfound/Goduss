import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';
import '../database/database.dart';

class UserRepository {
  final DatabaseProvider databaseProvider;

  UserRepository(this.databaseProvider);

  Future<void> insertUser(UserModel user) async {
    final db = await databaseProvider.database;
    await db.insert('user', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserModel?> getUserByUsernameAndPassword(
      String username, String password) async {
    final db = await databaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
