import 'package:hackathon/domain/entity/predefined_goal_entity.dart';

abstract class PreDefinedGoalRepository {
  Future<List<PredefinedGoalEntity>> loadGoals();
}