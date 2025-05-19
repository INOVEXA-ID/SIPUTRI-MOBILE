import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_bloc.dart';
import 'package:siputri_mobile/login/login_form.dart'; // sesuaikan dengan nama project

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(appBar: AppBar(title: Text('Login')), body: LoginForm()),
    );
  }
}
