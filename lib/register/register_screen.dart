import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_bloc.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Registrasi'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocProvider(
        create: (_) => RegisterBloc(),
        child: const RegisterForm(),
      ),
    );
  }
}
