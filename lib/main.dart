import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon/config/router.dart';
import 'package:hackathon/domain/usecases/get_predefined_goals.dart';
import 'package:hackathon/domain/usecases/goalUsecase.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:hackathon/services/dependency_injector.dart' as di;
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDepInject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppRouter>(create: (_) => AppRouter()),
        ChangeNotifierProvider(
          create: (context) => di.serviceLocator<GoalUseCase>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.serviceLocator<UserUseCase>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.serviceLocator<PreDefinedGoalUseCase>(),
        ),
      ],
      child: Builder(builder: (context) {
        final GoRouter goRouter =
            Provider.of<AppRouter>(context, listen: false).router;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routerConfig: goRouter,
          theme: ThemeData.dark(
            useMaterial3: true,
          ),
        );
      }),
    );
  }
}