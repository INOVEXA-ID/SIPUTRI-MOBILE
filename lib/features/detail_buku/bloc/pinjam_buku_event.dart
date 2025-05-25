part of 'pinjam_buku_bloc.dart';

sealed class PinjamBukuEvent {}

class PinjamBuku extends PinjamBukuEvent {
  final String idBuku;
  PinjamBuku({required this.idBuku});
}
