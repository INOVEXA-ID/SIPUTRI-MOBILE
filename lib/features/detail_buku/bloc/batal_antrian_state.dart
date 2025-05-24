part of 'batal_antrian_bloc.dart';

sealed class BatalAntrianState {}

final class BatalAntrianInitial extends BatalAntrianState {}

final class BatalAntrianSuccess extends BatalAntrianState {
  final String message;
  BatalAntrianSuccess({required this.message});
}

final class BatalAntrianError extends BatalAntrianState {
  final String message;
  BatalAntrianError({required this.message});
}
