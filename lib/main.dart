import 'package:app_pragma_prueba/config/router/app_router.dart';
import 'package:app_pragma_prueba/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.dev");
  // AppApi.init();
}

void main() async {
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Catbreeds",
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getLight(),
    );
  }
}
