part of 'pinjam_buku_bloc.dart';

sealed class PinjamBukuState {}

final class PinjamBukuInitial extends PinjamBukuState {}

final class PinjamBukuLoading extends PinjamBukuState {}

final class PinjamBukuLoaded extends PinjamBukuState {
  final String message;
  PinjamBukuLoaded(this.message);
}

final class PinjamBukuFailed extends PinjamBukuState {
  final String message;
  PinjamBukuFailed(this.message);
}
