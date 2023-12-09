import 'package:hackathon/data/local/databasehelper.dart';
import 'package:hackathon/data/models/user_model.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/entity/user_entity.dart';
import 'package:hackathon/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<bool> addCoins(int coinsToAdd) async {
    final db = await DatabaseHelper.instance.database;
    const userId = 1; //TODO Replace with the actual user ID
    List<Map> result =
        await db.query('User', where: 'id = ?', whereArgs: [userId]);
    if (result.isEmpty) return false;
    final currentUser = UserModel.fromJson(result.first);
    final newCoins = (currentUser.coins ?? 0) + coinsToAdd;

    // Update the coins value
    int updateCount = await db.update(
      'User',
      {'coins': newCoins},
      where: 'id = ?',
      whereArgs: [userId],
    );
    return updateCount > 0;
  }

  @override
  Future<UserEntity> loadUser() async {
    UserEntity user;
    final db = await DatabaseHelper.instance.database;
    final currentUser = await db.query('User');
    user = UserModel.fromJson(currentUser[0]);
    return user;
  }

  @override
  Future<bool> updateUser(GoalEntity goal) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
