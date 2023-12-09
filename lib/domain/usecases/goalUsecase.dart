import 'package:flutter/foundation.dart';
import 'package:hackathon/data/local/databasehelper.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/repository/goal_repository.dart';
import 'package:hackathon/services/notification_service.dart';

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

  Future<void> addGoal(GoalEntity goal) async {
    bool succuss = await goalRepository.addGoals(goal);
    //TODO CHECK FOR SUCCESS
    loadGoals();
  }

  Future<void> updateGoal(double thisMonthSaving, GoalEntity goal) async {
    // Check for overachievement and milestones
    handleOverachievement(thisMonthSaving,goal);
    checkForMilestone(goal);
    bool succuss = await goalRepository.updateGoal(goal);
    //TODO CHECK FOR SUCCESS
    loadGoals();
  }


  Future<void> deleteGoal(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('goals', where: 'id = ?', whereArgs: [id]);
    loadGoals();
  }

  int calculateExtraCoinsForOverachievement(double thisMonthSaving, double monthlyRequirement) {
    double overachievedAmount = thisMonthSaving - monthlyRequirement;
    return (overachievedAmount * 0.10).toInt(); // 10% of overachieved amount as coins
  }

  void handleOverachievement(double thisMonthSaving,  GoalEntity goal) {
    double monthlySavingRequirement = goal.calculateMonthlySaving();

    if (thisMonthSaving > monthlySavingRequirement) {
      // User has overachieved the monthly saving target
      // Logic to handle overachievement

      // Example: Notify the user about their overachievement
      NotificationService().showNotification(
        goal.id!,
        "Overachievement!",
        "Great job! You've saved more than your monthly target for ${goal.name}. Keep up the good work!"
      );

      // Example: Reward the user with additional coins
      int extraCoins = calculateExtraCoinsForOverachievement(thisMonthSaving, monthlySavingRequirement);
      //_user.addCoins(extraCoins);

      notifyListeners();
    }
     


    NotificationService().showNotification(
      goal.id!, 
      "Goal Overachieved!", 
      "Congratulations! You've saved more than your target for ${goal.name}."
    );

    //goal.targetAmount! *= 1.1; // Increase the goal target by 10%
     (goal); // Update the goal
  }

  void checkForMilestone(GoalEntity goal) {
    List<double> milestones = [0.25, 0.50, 0.75];
    double progress = goal.currentAmount!/ goal.targetAmount!;

    for (double milestone in milestones) {
      if (progress >= milestone && !goal.reachedMilestones!.contains(milestone)) {
        rewardUserForMilestone(goal, milestone);
        goal.reachedMilestones!.add(milestone); // Mark milestone as reached
        //updateGoal(goal);
      }
    }
  }

  void rewardUserForMilestone(GoalEntity goal, double milestone) {
    int coinsToReward = calculateMilestoneReward(milestone);
    /// Add provider of userusecase . addCoins
    //_user.addCoins(coinsToReward);

    NotificationService().showNotification(
      goal.id!, 
      "Milestone Reached!", 
      "You've reached a milestone in ${goal.name} and earned $coinsToReward coins!"
    );

    notifyListeners();
  }

  int calculateMilestoneReward(double milestone) {
    return (milestone * 100).toInt(); // Example calculation
  }

}
