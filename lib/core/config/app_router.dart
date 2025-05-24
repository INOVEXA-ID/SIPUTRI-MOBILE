import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:siputri_mobile/features/auth/repositories/auth_repository.dart';
import 'package:siputri_mobile/features/auth/screens/index.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/detail_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/ulasan_kamu_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/detail_buku_repository.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/ulasan_kamu_repository.dart';
import 'package:siputri_mobile/features/detail_buku/screens/daftar_tunggu_buku.dart';
import 'package:siputri_mobile/features/detail_buku/screens/detail_buku_screen.dart';
import 'package:siputri_mobile/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/repository/peminjaman_buku_repository.dart';
import 'package:siputri_mobile/features/detail_buku/detail_buku_screen.dart';
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
import 'package:siputri_mobile/features/search/bloc/buku_search_bloc.dart';
import 'package:siputri_mobile/features/search/repositories/buku_search_repository.dart';
import 'package:siputri_mobile/features/splash/bloc/splash_bloc.dart';
import 'package:siputri_mobile/features/splash/screens/index.dart';

class AppRouter {
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const homeScreen = "/home";
  static const splashScreen = "/splash-screen";
  static const navigationBarPage = "/navigation-bar";
  static const pdfRenderPage = "/pdf-render";
  static const daftarTungguBukuPage = "/daftar-tunggu-buku";
  static const detailBukuPage = "/detail-buku";
  static const detailBookScreen = "/BookDetailScreen";

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
                        (context) =>
                            BukuSearchBloc(BukuSearchRepository(DioClient())),
                  ),
                  BlocProvider(
                    create:
                        (_) => FavoritBloc(
                          FavoritRepository(dioClient: DioClient()),
                        )..add(GetFavorit()),
                  ),
                  BlocProvider(
                    create:
                        (_) => BookshelfBloc(
                          peminjamanRepository: PeminjamanBukuRepository(
                            DioClient(),
                          ),
                        )..add(FetchReadingList()),
                  ),
                ],
                child: NavigationBarPage(),
              ),
        );
      // case pdfRenderPage:
      //   return MaterialPageRoute(builder: (context) => PDFRenderScreen());
      case daftarTungguBukuPage:
        return MaterialPageRoute(
          builder: (context) => DaftarTungguBukuScreen(),
        );
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
