import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';

class GoalModel extends GoalEntity with EquatableMixin{
  final int? id;
  final String? name;
  final double? targetAmount;
  final double? currentAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<double>? reachedMilestones;

  GoalModel(
      {this.id,
      this.name,
      this.targetAmount,
      this.currentAmount,
      this.startDate,
      this.endDate,
      this.reachedMilestones,
      });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'reachedMilestones': jsonEncode(reachedMilestones),
      };

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      name: json['name'],
      targetAmount: json['targetAmount'],
      currentAmount: json['currentAmount'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      reachedMilestones: List.from(jsonDecode(json['reachedMilestones'])??[]),
    );
  }
}
