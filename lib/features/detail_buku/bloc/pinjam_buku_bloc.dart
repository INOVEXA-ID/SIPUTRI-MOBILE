import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/pinjam_buku_repository.dart';

part 'pinjam_buku_event.dart';
part 'pinjam_buku_state.dart';

class PinjamBukuBloc extends Bloc<PinjamBukuEvent, PinjamBukuState> {
  final PinjamBukuRepository pinjamBukuRepository;
  PinjamBukuBloc(this.pinjamBukuRepository) : super(PinjamBukuInitial()) {
    on<PinjamBuku>((event, emit) async {
      emit(PinjamBukuLoading());
      try {
        final message = await pinjamBukuRepository.pinjamBuku(
          idBuku: event.idBuku,
        );
        emit(PinjamBukuLoaded(message));
      } catch (e) {
        emit(PinjamBukuFailed(e.toString()));
      }
    });
  }
}
