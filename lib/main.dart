import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon/config/router.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    context.push('/test/newPage');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUseCase>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              '${user.name} have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
