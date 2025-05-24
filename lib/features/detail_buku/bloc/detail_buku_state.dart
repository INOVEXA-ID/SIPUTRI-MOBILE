part of 'detail_buku_bloc.dart';

sealed class DetailBukuState {}

final class DetailBukuInitial extends DetailBukuState {}

final class DetailBukuLoading extends DetailBukuState {}

final class DetailBukuLoaded extends DetailBukuState {
  final DetailBukuModel detailBukuModel;
  DetailBukuLoaded(this.detailBukuModel);
}

final class DetailBukuFailed extends DetailBukuState {
  final String message;
  DetailBukuFailed(this.message);
}
