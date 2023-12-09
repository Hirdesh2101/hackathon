import 'package:hackathon/data/models/predefined_goals.dart';
import 'package:hackathon/data/remote/my_json_data.dart';
import 'package:hackathon/domain/entity/predefined_goal_entity.dart';
import 'package:hackathon/domain/repository/pre_defined_goals_repository.dart';

class PredefinedGoalRepositoryImpl extends PreDefinedGoalRepository {
  @override
  Future<List<PredefinedGoalEntity>> loadGoals() async {
    List<PredefinedGoalEntity> myGoals = [];
    myGoals = goals.map((e) => PredefineGoalModel.fromJson(e)).toList();
    return myGoals;
  }
}
