import 'dart:io';

abstract class EditProfileEvent {}

class EditProfileSubmitted extends EditProfileEvent {
  final String nama;
  final String telepon;
  final String alamat;
  final String jenisKelamin;
  final File? foto;

  EditProfileSubmitted({
    required this.nama,
    required this.telepon,
    required this.alamat,
    required this.jenisKelamin,
    this.foto,
  });
}
