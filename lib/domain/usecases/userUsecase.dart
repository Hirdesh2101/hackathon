import 'package:flutter/foundation.dart';
import 'package:hackathon/domain/entity/user_entity.dart';
import 'package:hackathon/domain/repository/user_repository.dart';

class UserUseCase with ChangeNotifier {
  final UserRepository userRepository;
  UserEntity _user = const UserEntity(id:0,name: '',coins: 0,totalInvesed: 0);

  UserUseCase(this.userRepository) {
    loadUser();
  }

  UserEntity get user => _user;

  Future<void> loadUser() async {
    _user = await userRepository.loadUser();
    notifyListeners();
  }

  Future<void> addCoins(int coinsToAdd) async {
    var success = await userRepository.addCoins(coinsToAdd);
    //TODO handle success
    loadUser();
  }
}
