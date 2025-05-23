part of 'buku_bloc.dart';

sealed class BukuState {}

class BukuInitial extends BukuState {}

class BukuLoading extends BukuState {}

class BukuLoaded extends BukuState {
  final BukuModel buku;
  BukuLoaded(this.buku);
}

class BukuError extends BukuState {
  final String message;
  BukuError(this.message);
}
