import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/config/app_router.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'package:siputri_mobile/core/widgets/my_text.dart';
import 'package:siputri_mobile/features/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          if (state.isLogedIn) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.homeScreen,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.loginScreen,
              (route) => false,
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        body: Center(
          child: MyText(title: "SIPUTRI", color: Colors.white, fontSize: 32),
        ),
      ),
    );
  }
}
