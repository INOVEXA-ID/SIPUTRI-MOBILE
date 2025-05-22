part of 'auth_bloc.dart';

sealed class AuthEvent {}

class LoginEmailChanged extends AuthEvent {
  final String email;
  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends AuthEvent {
  final String password;
  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends AuthEvent {}
