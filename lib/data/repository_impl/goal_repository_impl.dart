import 'package:hackathon/data/local/databasehelper.dart';
import 'package:hackathon/data/models/goal_model.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/repository/goal_repository.dart';

class GoalRepositoryImpl extends GoalRepository {
  @override
  Future<List<GoalEntity>> loadGoals() async {
    List<GoalEntity> myGoals = [];
    final db = await DatabaseHelper.instance.database;
    final goalMaps = await db.query('goals');
    myGoals = goalMaps.map((e) => GoalModel.fromJson(e)).toList();
    return myGoals;
  }

  @override
  Future<bool> addGoals(GoalEntity goal) async {
    final db = await DatabaseHelper.instance.database;
    var succuss = await db.insert('goals', (goal as GoalModel).toJson());
    if (succuss == 0) return false;
    return true;
  }

  @override
  Future<bool> updateGoal(GoalEntity goal) async {
    final db = await DatabaseHelper.instance.database;
    var succuss = await db.update('goals', (goal as GoalModel).toJson(),
        where: 'id = ?', whereArgs: [goal.id]);
    if (succuss == 0) return false;
    return true;
  }
}
