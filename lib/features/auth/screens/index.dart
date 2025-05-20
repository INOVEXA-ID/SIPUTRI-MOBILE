import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/config/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.homeScreen,
                (route) => false,
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
