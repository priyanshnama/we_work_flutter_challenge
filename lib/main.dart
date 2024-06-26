import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';
import 'package:we_work_flutter_challenge/theme/theme.dart';
import 'package:we_work_flutter_challenge/ui/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('moviesCache');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeMoviesRepository>(
          create: (_) => WeMoviesRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
