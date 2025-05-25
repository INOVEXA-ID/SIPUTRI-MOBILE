part of 'daftar_antrian_bloc.dart';

sealed class DaftarAntrianState {}

final class DaftarAntrianInitial extends DaftarAntrianState {}

final class DaftarAntrianLoading extends DaftarAntrianState {}

final class DaftarAntrianLoaded extends DaftarAntrianState {
  final DaftarAntrianModel daftarAntrianModel;
  DaftarAntrianLoaded(this.daftarAntrianModel);
}

final class DaftarAntrianFailed extends DaftarAntrianState {
  final String message;
  DaftarAntrianFailed(this.message);
}
