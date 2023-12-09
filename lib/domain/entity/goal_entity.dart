import 'package:equatable/equatable.dart';

class GoalEntity extends Equatable {
  final int? id;
  final String? name;
  final double? targetAmount;
  final double? currentAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<double>? reachedMilestones;

  const GoalEntity({
    this.id,
    this.name,
    this.targetAmount,
    this.currentAmount,
    this.startDate,
    this.endDate,
    this.reachedMilestones,
  });

  double calculateMonthlySaving() {
    int months = endDate!.difference(startDate!).inDays ~/ 30;
    return months > 0 ? (targetAmount! - currentAmount!) / months : 0;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        targetAmount,
        currentAmount,
        startDate,
        endDate,
        reachedMilestones
      ];
}
