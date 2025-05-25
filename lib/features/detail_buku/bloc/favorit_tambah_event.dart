part of 'favorit_tambah_bloc.dart';

sealed class FavoritEvent {}

class PostFavoritEvent extends FavoritEvent {
  final int idBuku;
  PostFavoritEvent({required this.idBuku});
}
