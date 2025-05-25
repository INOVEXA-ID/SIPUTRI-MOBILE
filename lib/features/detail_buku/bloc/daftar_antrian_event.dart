part of 'daftar_antrian_bloc.dart';

sealed class DaftarAntrianEvent {}

class DaftarAntrianEventLoad extends DaftarAntrianEvent {
  final String idBuku;
  DaftarAntrianEventLoad(this.idBuku);
}
