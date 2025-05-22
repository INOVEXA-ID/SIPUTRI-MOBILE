import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:siputri_mobile/core/config/app_router.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen:
          (prev, next) =>
              prev.isSuccess != next.isSuccess ||
              prev.isFailure != next.isFailure,
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacementNamed(context, AppRouter.navigationBarPage);
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage.isNotEmpty
                    ? state.errorMessage
                    : "Login gagal!",
              ),
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/logo_fix.png',
                width: 120,
                height: 120,
              ),
              const Text(
                "SIPUTRI",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Text(
                "SISTEM PERPUSTAKAAN ELEKTRONIK",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
              ),
              const Text(
                "POLITEKNIK NEGERI JEMBER",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
              ),
              const SizedBox(height: 20),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextFormField(
                    initialValue: state.email,
                    onChanged:
                        (value) => context.read<LoginBloc>().add(
                          LoginEmailChanged(value),
                        ),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Email tidak boleh kosong' : null,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: TextInputType.emailAddress,
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextFormField(
                    initialValue: state.password,
                    obscureText: true,
                    onChanged:
                        (value) => context.read<LoginBloc>().add(
                          LoginPasswordChanged(value),
                        ),
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? 'Password tidak boleh kosong'
                                : null,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          state.isSubmitting
                              ? null
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(
                                    LoginSubmitted(),
                                  );
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: Colors.blue[600],
                        elevation: 4,
                      ),
                      child:
                          state.isSubmitting
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: () {
                      // Panggil Navigator ke halaman register
                    },
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 250),
              const Text(
                "Oleh:",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_polije_biru.png',
                    width: 75,
                    height: 75,
                  ),
                  Image.asset(
                    "assets/images/logo_polije_sip.png",
                    width: 75,
                    height: 75,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
