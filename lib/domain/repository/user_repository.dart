import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> loadUser();
  Future<bool> addCoins(int coinsToAdd);
  Future<bool> updateUser(GoalEntity goal);
}