part of 'ulasan_kamu_bloc.dart';

sealed class UlasanKamuState {}

final class UlasanKamuInitial extends UlasanKamuState {}

final class UlasanKamuLoading extends UlasanKamuState {}

final class UlasanKamuLoaded extends UlasanKamuState {
  final UlasanKamuModel data;
  UlasanKamuLoaded(this.data);
}

final class PostUlasanKamuLoaded extends UlasanKamuState {
  final UlasanKamuModel data;
  PostUlasanKamuLoaded(this.data);
}

final class UlasanKamuFailed extends UlasanKamuState {
  final String message;
  UlasanKamuFailed(this.message);
}

final class PostUlasanKamuFailed extends UlasanKamuState {
  final String message;
  PostUlasanKamuFailed(this.message);
}
