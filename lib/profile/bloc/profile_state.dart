part of 'profile_bloc.dart';

class ProfileState {
  final String nama;
  final String nim;
  final String jenisKelamin;
  final String noHp;
  final String alamat;
  final String email;

  ProfileState({
    required this.nama,
    required this.nim,
    required this.jenisKelamin,
    required this.noHp,
    required this.alamat,
    required this.email,
  });

  factory ProfileState.initial() {
    return ProfileState(
      nama: '',
      nim: '',
      jenisKelamin: '',
      noHp: '',
      alamat: '',
      email: '',
    );
  }
}
