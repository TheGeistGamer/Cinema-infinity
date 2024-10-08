import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_cinema/src/config/router/app_router.dart';
import 'package:infinity_cinema/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Carga de variables de entorno
  await dotenv.load(fileName: '.env');
  // Referencia a todos los providers
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Infinity Cinema',
      theme: AppTheme().getTheme(),
    );
  }
}
