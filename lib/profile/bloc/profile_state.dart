part of 'profile_bloc.dart';

class ProfileState {
  final String nama;
  final String nim;
  final String jenisKelamin;
  final String noHp;
  final String alamat;
  final String email;
  final String? fotoUrl;

  ProfileState({
    required this.nama,
    required this.nim,
    required this.jenisKelamin,
    required this.noHp,
    required this.alamat,
    required this.email,
    this.fotoUrl,
  });

  factory ProfileState.initial() => ProfileState(
    nama: '',
    nim: '',
    jenisKelamin: '',
    noHp: '',
    alamat: '',
    email: '',
    fotoUrl: null,
  );

  factory ProfileState.fromUser(User user) => ProfileState(
    nama: user.nama,
    nim: user.nim ?? '',
    jenisKelamin: user.jenisKelamin,
    noHp: user.telepon,
    alamat: user.alamat,
    email: user.email ?? '',
    fotoUrl: user.foto,
  );
}
