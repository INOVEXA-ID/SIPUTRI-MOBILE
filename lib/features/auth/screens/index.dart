import 'package:flutter/material.dart';
import 'package:siputri_mobile/features/auth/components/form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Login')), body: LoginForm());
  }
}
