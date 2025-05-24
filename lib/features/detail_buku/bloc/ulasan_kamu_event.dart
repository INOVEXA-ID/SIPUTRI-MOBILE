part of 'ulasan_kamu_bloc.dart';

sealed class UlasanKamuEvent {}

class GetUlasanKamu extends UlasanKamuEvent {
  final String id;
  GetUlasanKamu({required this.id});
}

class PostUlasanKamu extends UlasanKamuEvent {
  final String idUser;
  final String idBuku;
  final String ulasan;
  final double rating;

  PostUlasanKamu({
    required this.idUser,
    required this.idBuku,
    required this.ulasan,
    required this.rating,
  });
}

class UpdateUlasanKamu extends UlasanKamuEvent {
  final String idUser;
  final String idBuku;
  final String ulasan;
  final double rating;

  UpdateUlasanKamu({
    required this.idUser,
    required this.idBuku,
    required this.ulasan,
    required this.rating,
  });
}
