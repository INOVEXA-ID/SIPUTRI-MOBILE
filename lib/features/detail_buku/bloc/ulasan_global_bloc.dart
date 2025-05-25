import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/models/ulasan_global_model.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/ulasan_global_repository.dart';

part 'ulasan_global_event.dart';
part 'ulasan_global_state.dart';

class UlasanGlobalBloc extends Bloc<UlasanGlobalEvent, UlasanGlobalState> {
  final UlasanGlobalRepository ulasanGlobalRepository;
  UlasanGlobalBloc(this.ulasanGlobalRepository) : super(UlasanGlobalInitial()) {
    on<GetUlasanGlobalEvent>((event, emit) async {
      try {
        emit(UlasanGlobalLoading());
        final ulasanGlobal = await ulasanGlobalRepository.getUlasanGlobal(
          id: event.bukuId,
        );
        emit(UlasanGlobalLoaded(ulasanGlobal));
      } catch (e) {
        emit(UlasanGlobalFailed(e.toString()));
      }
    });
  }
}
