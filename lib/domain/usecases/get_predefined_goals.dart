import 'package:flutter/material.dart';
import 'package:hackathon/domain/entity/predefined_goal_entity.dart';
import 'package:hackathon/domain/repository/pre_defined_goals_repository.dart';

class PreDefinedGoalUseCase with ChangeNotifier {
  final PreDefinedGoalRepository preDefinedGoalRepository;

  List<PredefinedGoalEntity> _goals = [];

  PreDefinedGoalUseCase(this.preDefinedGoalRepository) {
    loadGoals();
  }

  List<PredefinedGoalEntity> get goals => _goals;

  Future<void> loadGoals() async {
    _goals = await preDefinedGoalRepository.loadGoals();
    notifyListeners();
  }
}
