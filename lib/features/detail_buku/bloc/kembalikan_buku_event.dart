part of 'kembalikan_buku_bloc.dart';

sealed class KembalikanBukuEvent {}

class KembalikanBuku extends KembalikanBukuEvent {
  final String idBuku;
  KembalikanBuku({required this.idBuku});
}
