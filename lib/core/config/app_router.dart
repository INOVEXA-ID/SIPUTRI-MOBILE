import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:siputri_mobile/features/auth/repositories/auth_repository.dart';
import 'package:siputri_mobile/features/auth/screens/index.dart';
import 'package:siputri_mobile/features/favorit/bloc/favorit_bloc.dart';
import 'package:siputri_mobile/features/favorit/repositories/favorit_repository.dart';
import 'package:siputri_mobile/features/home/bloc/buku_bloc.dart';
import 'package:siputri_mobile/features/home/repositories/buku_repository.dart';
import 'package:siputri_mobile/features/home/screens/index.dart';
import 'package:siputri_mobile/features/navigation/bloc/navigation_bloc.dart';
import 'package:siputri_mobile/features/navigation/index.dart';
import 'package:siputri_mobile/features/pdf_render/index.dart';
import 'package:siputri_mobile/features/register/bloc/register_bloc.dart';
import 'package:siputri_mobile/features/register/repositories/register_repository.dart';
import 'package:siputri_mobile/features/register/screens/index.dart';
import 'package:siputri_mobile/features/splash/bloc/splash_bloc.dart';
import 'package:siputri_mobile/features/splash/screens/index.dart';

class AppRouter {
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const homeScreen = "/home";
  static const splashScreen = "/splash-screen";
  static const navigationBarPage = "/navigation-bar";
  static const pdfRenderPage = "/pdf-render";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthBloc(AuthRepository(DioClient())),
                child: LoginScreen(),
              ),
        );
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
      case navigationBarPage:
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => NavigationBloc()),
                  BlocProvider(
                    create:
                        (context) =>
                            BukuBloc(BukuRepository(DioClient()))
                              ..add(LoadBuku()),
                  ),
                  BlocProvider(
                    create:
                        (_) => FavoritBloc(
                          FavoritRepository(dioClient: DioClient()),
                        )..add(GetFavorit()),
                  ),
                ],
                child: NavigationBarPage(),
              ),
        );
      case pdfRenderPage:
        return MaterialPageRoute(builder: (context) => const PDFRenderScreen());
      case registerScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (_) => RegisterBloc(RegisterRepository(DioClient())),
                child: RegisterScreen(),
              ),
        );
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
