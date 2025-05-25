import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/batal_antrian_repository.dart';

part 'batal_antrian_event.dart';
part 'batal_antrian_state.dart';

class BatalAntrianBloc extends Bloc<BatalAntrianEvent, BatalAntrianState> {
  final BatalAntrianRepository batalAntrianRepository;
  BatalAntrianBloc(this.batalAntrianRepository) : super(BatalAntrianInitial()) {
    on<BatalAntrian>((event, emit) async {
      try {
        final message = await batalAntrianRepository.antriBuku(
          idBuku: event.idBuku,
        );
        emit(BatalAntrianSuccess(message: message));
      } catch (e) {
        emit(BatalAntrianError(message: e.toString()));
      }
    });
  }
}
