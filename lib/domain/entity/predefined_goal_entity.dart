import 'package:equatable/equatable.dart';

class PredefinedGoalEntity extends Equatable {
  final int? id;
  final String? name;
  final double? targetAmount;
  final double? currentAmount;
  final String? imageURL;
  final DateTime? startDate;
  final DateTime? endDate;

  const PredefinedGoalEntity({
    this.id,
    this.name,
    this.targetAmount,
    this.currentAmount,
    this.startDate,
    this.endDate,
    this.imageURL,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        targetAmount,
        currentAmount,
        imageURL,
        startDate,
        endDate,
      ];
}
