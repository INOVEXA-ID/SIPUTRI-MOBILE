part of 'batal_antrian_bloc.dart';

sealed class BatalAntrianEvent {}

class BatalAntrian extends BatalAntrianEvent {
  final String idBuku;
  BatalAntrian({required this.idBuku});
}
