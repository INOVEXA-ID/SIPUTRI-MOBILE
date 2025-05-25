part of 'buku_dibaca_bloc.dart';

sealed class BukuDibacaState {}

final class BukuDibacaInitial extends BukuDibacaState {}

final class BukuDibacaLoading extends BukuDibacaState {}

final class BukuDibacaLoaded extends BukuDibacaState {
  final BukuDibacaModel bukuDibacaModel;
  BukuDibacaLoaded(this.bukuDibacaModel);
}

final class BukuDibacaFailed extends BukuDibacaState {
  final String message;
  BukuDibacaFailed(this.message);
}
