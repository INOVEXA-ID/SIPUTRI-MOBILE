part of 'antrian_buku_bloc.dart';

sealed class AntrianBukuState {}

final class AntrianBukuInitial extends AntrianBukuState {}

final class AntrianBukuLoading extends AntrianBukuState {}

final class AntrianBukuSuccess extends AntrianBukuState {
  final String message;
  AntrianBukuSuccess(this.message);
}

final class AntrianBukuError extends AntrianBukuState {
  final String message;
  AntrianBukuError(this.message);
}
