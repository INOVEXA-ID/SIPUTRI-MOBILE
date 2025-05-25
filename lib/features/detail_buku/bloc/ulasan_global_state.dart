part of 'ulasan_global_bloc.dart';

sealed class UlasanGlobalState {}

final class UlasanGlobalInitial extends UlasanGlobalState {}

final class UlasanGlobalLoading extends UlasanGlobalState {}

final class UlasanGlobalLoaded extends UlasanGlobalState {
  final UlasanGlobalModel ulasanGlobalModel;
  UlasanGlobalLoaded(this.ulasanGlobalModel);
}

final class UlasanGlobalFailed extends UlasanGlobalState {
  final String message;
  UlasanGlobalFailed(this.message);
}
