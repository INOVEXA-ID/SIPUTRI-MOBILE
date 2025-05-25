import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/kembalikan_buku_repository.dart';

part 'kembalikan_buku_event.dart';
part 'kembalikan_buku_state.dart';

class KembalikanBukuBloc
    extends Bloc<KembalikanBukuEvent, KembalikanBukuState> {
  final KembalikanBukuRepository kembalikanBukuRepository;
  KembalikanBukuBloc(this.kembalikanBukuRepository)
    : super(KembalikanBukuInitial()) {
    on<KembalikanBuku>((event, emit) async {
      try {
        emit(KembalikanBukuLoading());
        final message = await kembalikanBukuRepository.kembalikanBuku(
          idBuku: event.idBuku,
        );
        emit(KembalikanBukuSuccess(message));
      } catch (e) {
        emit(KembalikanBukuError(e.toString()));
      }
    });
  }
}
