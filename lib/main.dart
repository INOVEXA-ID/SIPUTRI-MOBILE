import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:siputri_mobile/core/config/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await TokenStorage().init();
  await initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeAnimationStyle: AnimationStyle(
        curve: Curves.decelerate,
        reverseCurve: Curves.easeInOutBack,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: AppRouter.splashScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
