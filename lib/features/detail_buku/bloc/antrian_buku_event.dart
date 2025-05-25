part of 'antrian_buku_bloc.dart';

sealed class AntrianBukuEvent {}

class PostAntrianBukuEvent extends AntrianBukuEvent {
  final String idBuku;
  PostAntrianBukuEvent({required this.idBuku});
}
