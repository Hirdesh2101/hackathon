import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final int? id;
  final String? name;
  final int? coins;
  final double? totalInvesed;

  const UserEntity(
      {this.id,
      this.name,
      this.totalInvesed,
      this.coins,
      });

      @override
      List<Object?> get props => [
        id,
        name,
        coins,
        totalInvesed
      ];
}