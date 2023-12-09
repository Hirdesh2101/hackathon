import 'package:equatable/equatable.dart';
import 'package:hackathon/domain/entity/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin{
  final int? id;
  final String? name;
  final int? coins;
  final double? totalInvesed;

  UserModel(
      {this.id,
      this.name,
      this.coins,
      this.totalInvesed
      });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'coins': coins,
      };

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      coins: json['coins'],
      totalInvesed: json['totalInvesed']
    );
  }
}
