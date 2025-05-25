import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/antrian_buku_repository.dart';

part 'antrian_buku_event.dart';
part 'antrian_buku_state.dart';

class AntrianBukuBloc extends Bloc<AntrianBukuEvent, AntrianBukuState> {
  final AntrianBukuRepository antrianBukuRepository;
  AntrianBukuBloc(this.antrianBukuRepository) : super(AntrianBukuInitial()) {
    on<PostAntrianBukuEvent>((event, emit) async {
      emit(AntrianBukuLoading());
      try {
        final message = await antrianBukuRepository.antriBuku(
          idBuku: event.idBuku,
        );
        emit(AntrianBukuSuccess(message));
      } catch (e) {
        emit(AntrianBukuError(e.toString()));
      }
    });
  }
}
