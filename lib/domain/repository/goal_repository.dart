import 'package:hackathon/domain/entity/goal_entity.dart';

abstract class GoalRepository {
  Future<List<GoalEntity>> loadGoals();
  Future<bool> addGoals(GoalEntity goal);
  Future<bool> updateGoal(GoalEntity goal);
}