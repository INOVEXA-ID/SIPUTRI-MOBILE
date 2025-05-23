import 'package:flutter/material.dart';
import 'package:siputri_mobile/features/register/components/form.dart';

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
      body: const RegisterForm(),
    );
  }
}
