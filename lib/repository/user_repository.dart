import 'package:evaluation/data_base/data_base.dart';
import 'package:evaluation/models/user.dart';

class UserRepository {
  final DatabaseHelper _dbHelper;

  UserRepository(this._dbHelper);

  Future<void> createTable() async {
    final conn = await _dbHelper.conn;
    try {
      await conn.query('''
        CREATE TABLE IF NOT EXISTS user (
          id INT AUTO_INCREMENT PRIMARY KEY,
          userId BIGINT NOT NULL,
          userName VARCHAR(255) NOT NULL,
          userPassword VARCHAR(255) NOT NULL
        )
      ''');
      print('Table "user" created successfully.');
    } catch (e) {
      print('Error creating table: $e');
    }
  }

  Future<void> insertOrUpdateUser(User user, Function() onUserSaved) async {
    final conn = await _dbHelper.conn;
    var results = await conn.query(
      'SELECT * FROM user WHERE userId = ?',
      [user.userId],
    );

    if (results.isNotEmpty) {
      await conn.query(
        'UPDATE user SET userName = ?, userPassword = ? WHERE userId = ?',
        [user.userName, user.userPassword, user.userId],
      );
    } else {
      await conn.query(
        'INSERT INTO user (userId, userName, userPassword) VALUES (?, ?, ?)',
        [user.userId, user.userName, user.userPassword],
      );
    }

    print("Utilisateur sauvegardé.");
    onUserSaved();
  }
}
