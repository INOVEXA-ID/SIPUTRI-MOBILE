part of 'register_bloc.dart';

sealed class RegisterEvent {}

final class RegisterSubmitted extends RegisterEvent {
  final String nim;
  final String nama;
  final String jenisKelamin;
  final String telepon;
  final String alamat;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterSubmitted({
    required this.nim,
    required this.nama,
    required this.jenisKelamin,
    required this.telepon,
    required this.alamat,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}
