import 'package:hackathon/data/models/goal_model.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';

abstract class GoalRepository {
  Future<List<GoalEntity>> loadGoals();
  Future<bool> addGoals(GoalModel goal);
  Future<bool> updateGoal(GoalEntity goal);
}