import 'package:flutter/material.dart';
import 'package:hackathon/data/local/databasehelper.dart';
import 'package:hackathon/data/models/goal_model.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/repository/goal_repository.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:hackathon/services/notification_service.dart';
import 'package:provider/provider.dart';

class GoalUseCase with ChangeNotifier {
  final GoalRepository goalRepository;

  List<GoalEntity> _goals = [];

  GoalUseCase(this.goalRepository) {
    loadGoals();
  }

  List<GoalEntity> get goals => _goals;

  Future<void> loadGoals() async {
    _goals = await goalRepository.loadGoals();
    notifyListeners();
  }

  Future<void> addGoal(GoalModel goal) async {
    bool succuss = await goalRepository.addGoals(goal);
    //TODO CHECK FOR SUCCESS
    loadGoals();
  }

  Future<void> updateGoal(
      double thisMonthSaving, GoalEntity goal, BuildContext context) async {
    // Check for overachievement and milestones
    handleOverachievement(thisMonthSaving, goal, context);
    //await checkForMilestone(goal, context);
    GoalModel goalEntity = GoalModel(
        id: goal.id,
        currentAmount: goal.currentAmount! + thisMonthSaving,
        targetAmount: goal.targetAmount,
        name: goal.name,
        startDate: goal.startDate,
        endDate: goal.endDate);
    bool succuss = await goalRepository.updateGoal(goalEntity);
    //TODO CHECK FOR SUCCESS
    loadGoals();
  }

  Future<void> deleteGoal(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('goals', where: 'id = ?', whereArgs: [id]);
    loadGoals();
  }

  int calculateExtraCoinsForOverachievement(
      double thisMonthSaving, double monthlyRequirement) {
    double overachievedAmount = thisMonthSaving - monthlyRequirement;
    return (overachievedAmount * 0.10).toInt();
  }

  void handleOverachievement(
      double thisMonthSaving, GoalEntity goal, BuildContext context) {
    double monthlySavingRequirement = goal.calculateMonthlySaving();

    if (thisMonthSaving > monthlySavingRequirement) {
      NotificationService().showNotification(goal.id!, "Overachievement!",
          "Great job! You've saved more than your monthly target for ${goal.name}. Keep up the good work!");
      int extraCoins = calculateExtraCoinsForOverachievement(
          thisMonthSaving, monthlySavingRequirement);

      final userProvider = Provider.of<UserUseCase>(context, listen: false);
      userProvider.addCoins(extraCoins);

      notifyListeners();
    }
  }

  Future<void> checkForMilestone(GoalModel goal, BuildContext context) async {
    List<double> milestones = [0.25, 0.50, 0.75];
    double progress = goal.currentAmount! / goal.targetAmount!;

    for (double milestone in milestones) {
      if (progress >= milestone &&
          !goal.reachedMilestones!.contains(milestone)) {
        rewardUserForMilestone(goal, milestone, context);
        goal.reachedMilestones!.add(milestone);
        await goalRepository.updateGoal(goal);
      }
    }
  }

  void rewardUserForMilestone(
      GoalEntity goal, double milestone, BuildContext context) {
    int coinsToReward = calculateMilestoneReward(milestone);
    final userProvider = Provider.of<UserUseCase>(context, listen: false);
    userProvider.addCoins(coinsToReward);
    NotificationService().showNotification(goal.id!, "Milestone Reached!",
        "You've reached a milestone in ${goal.name} and earned $coinsToReward coins!");
    notifyListeners();
  }

  int calculateMilestoneReward(double milestone) {
    return (milestone * 100).toInt();
  }
}
