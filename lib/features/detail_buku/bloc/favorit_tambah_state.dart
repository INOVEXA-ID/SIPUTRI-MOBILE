part of 'favorit_tambah_bloc.dart';

sealed class FavoritState {}

final class FavoritInitial extends FavoritState {}

final class FavoritLoading extends FavoritState {}

final class FavoritSuccess extends FavoritState {
  final String message;

  FavoritSuccess(this.message);
}

final class FavoritError extends FavoritState {
  final String message;

  FavoritError(this.message);
}
