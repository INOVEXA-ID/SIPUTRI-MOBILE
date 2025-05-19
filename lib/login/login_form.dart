import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_bloc.dart';
import '../login/login_event.dart';
import '../login/login_state.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged:
                    (value) =>
                        context.read<LoginBloc>().add(LoginEmailChanged(value)),
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                obscureText: true,
                onChanged:
                    (value) => context.read<LoginBloc>().add(
                      LoginPasswordChanged(value),
                    ),
                decoration: InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(LoginSubmitted());
                },
                child:
                    state.isSubmitting
                        ? CircularProgressIndicator()
                        : Text('Login'),
              ),
              if (state.isFailure)
                Text('Login gagallll', style: TextStyle(color: Colors.red)),
              if (state.isSuccess)
                Text('Login berhasil', style: TextStyle(color: Colors.green)),
            ],
          ),
        );
      },
    );
  }
}
