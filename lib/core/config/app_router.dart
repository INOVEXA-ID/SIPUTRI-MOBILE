import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/auth/screens/index.dart';
import 'package:siputri_mobile/features/home/index.dart';
import 'package:siputri_mobile/features/splash/bloc/splash_bloc.dart';
import 'package:siputri_mobile/features/splash/screens/index.dart';

class AppRouter {
  static const loginScreen = "/login";
  static const homeScreen = "/home";
  static const splashScreen = "/splash-screen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case splashScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SplashBloc()..add(LoadSplash()),
                child: const SplashScreen(),
              ),
        );
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(child: Text('Halaman tidak ditemukan')),
              ),
        );
    }
  }
}
