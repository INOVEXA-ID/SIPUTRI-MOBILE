part of 'favorit_bloc.dart';

sealed class FavoritState {}

final class FavoritInitial extends FavoritState {}

final class FavoritLoading extends FavoritState {}

final class FavoritLoaded extends FavoritState {
  final FavoritModel favoritModel;
  FavoritLoaded(this.favoritModel);
}

final class FavoritFailed extends FavoritState {
  final String message;
  FavoritFailed(this.message);
}
