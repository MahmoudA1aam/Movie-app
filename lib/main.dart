import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/app_router/app_router.dart';
import 'package:movie/core/theme/application_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MovieApp(
    appRouter: AppRouter(),
  ));
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ApplicationTheme.dark,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
