import 'package:get_it/get_it.dart';
import 'package:hackathon/data/repository_impl/goal_repository_impl.dart';
import 'package:hackathon/data/repository_impl/user_repository_impl.dart';
import 'package:hackathon/domain/repository/goal_repository.dart';
import 'package:hackathon/domain/repository/user_repository.dart';
import 'package:hackathon/domain/usecases/goalUsecase.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initDepInject() async{
  //UseCases
  serviceLocator.registerFactory(() => GoalUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => UserUseCase(serviceLocator()));

  //Repository Implement Layer
  serviceLocator.registerFactory<GoalRepository>(() => GoalRepositoryImpl());
  serviceLocator.registerFactory<UserRepository>(() => UserRepositoryImpl());
}