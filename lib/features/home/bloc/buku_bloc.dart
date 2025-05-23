import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/home/models/buku_model.dart';
import 'package:siputri_mobile/features/home/repositories/buku_repository.dart';

part 'buku_event.dart';
part 'buku_state.dart';

class BukuBloc extends Bloc<BukuEvent, BukuState> {
  final BukuRepository bukuRepository;
  BukuBloc(this.bukuRepository) : super(BukuInitial()) {
    on<LoadBuku>((event, emit) async {
      emit(BukuLoading());
      try {
        final books = await bukuRepository.getBooks();
        emit(BukuLoaded(books));
      } catch (e) {
        emit(BukuError(e.toString()));
      }
    });
  }
}
