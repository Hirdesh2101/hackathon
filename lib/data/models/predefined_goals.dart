import 'package:equatable/equatable.dart';
import 'package:hackathon/domain/entity/predefined_goal_entity.dart';

class PredefineGoalModel extends PredefinedGoalEntity with EquatableMixin {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final double? targetAmount;
  @override
  final double? currentAmount;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? imageURL;

  PredefineGoalModel(
      {this.id,
      this.name,
      this.targetAmount,
      this.currentAmount,
      this.startDate,
      this.endDate,
      this.imageURL});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'imageURL': imageURL,
      };

  factory PredefineGoalModel.fromJson(Map<String, dynamic> json) {
    return PredefineGoalModel(
      id: json['id'],
      name: json['name'],
      targetAmount: double.parse(json['targetAmount'].toString()),
      currentAmount: double.parse(json['currentAmount'].toString()),
      imageURL: json['imageURL'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
