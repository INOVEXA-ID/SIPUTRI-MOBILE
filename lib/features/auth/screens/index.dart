import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:siputri_mobile/features/auth/components/form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(appBar: AppBar(title: Text('Login')), body: LoginForm()),
    );
  }
}
