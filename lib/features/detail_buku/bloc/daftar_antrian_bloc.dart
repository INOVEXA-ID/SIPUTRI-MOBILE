import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/models/daftar_antrian.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/daftar_antrian_repository.dart';

part 'daftar_antrian_event.dart';
part 'daftar_antrian_state.dart';

class DaftarAntrianBloc extends Bloc<DaftarAntrianEvent, DaftarAntrianState> {
  final DaftarAntrianRepository daftarAntrianRepository;
  DaftarAntrianBloc(this.daftarAntrianRepository)
    : super(DaftarAntrianInitial()) {
    on<DaftarAntrianEventLoad>((event, emit) async {
      try {
        emit(DaftarAntrianLoading());
        final daftarAntrian = await daftarAntrianRepository.getDetailBooks(
          idBuku: event.idBuku,
        );
        emit(DaftarAntrianLoaded(daftarAntrian));
      } catch (e) {
        emit(DaftarAntrianFailed(e.toString()));
      }
    });
  }
}
