part of 'kembalikan_buku_bloc.dart';

sealed class KembalikanBukuState {}

final class KembalikanBukuInitial extends KembalikanBukuState {}

final class KembalikanBukuLoading extends KembalikanBukuState {}

final class KembalikanBukuSuccess extends KembalikanBukuState {
  final String message;
  KembalikanBukuSuccess(this.message);
}

final class KembalikanBukuError extends KembalikanBukuState {
  final String message;
  KembalikanBukuError(this.message);
}
