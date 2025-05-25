import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/home/models/buku_dibaca_model.dart';
import 'package:siputri_mobile/features/home/repositories/buku_dibaca_repository.dart';

part 'buku_dibaca_event.dart';
part 'buku_dibaca_state.dart';

class BukuDibacaBloc extends Bloc<BukuDibacaEvent, BukuDibacaState> {
  final BukuDibacaRepository bukuDibacaRepository;
  BukuDibacaBloc(this.bukuDibacaRepository) : super(BukuDibacaInitial()) {
    on<GetBukuDibacaEvent>((event, emit) async {
      try {
        emit(BukuDibacaLoading());
        final books = await bukuDibacaRepository.getBukuDibaca();
        emit(BukuDibacaLoaded(books));
      } catch (e) {
        emit(BukuDibacaFailed(e.toString()));
      }
    });
  }
}
