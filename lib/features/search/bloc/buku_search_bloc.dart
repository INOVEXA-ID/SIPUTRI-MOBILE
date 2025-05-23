import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/search/models/buku_search_model.dart';
import 'package:siputri_mobile/features/search/repositories/buku_search_repository.dart';

part 'buku_search_event.dart';
part 'buku_search_state.dart';

class BukuSearchBloc extends Bloc<BukuSearchEvent, BukuSearchState> {
  final BukuSearchRepository bukuRepository;
  BukuSearchBloc(this.bukuRepository) : super(BukuSearchInitial()) {
    on<LoadSearchBuku>((event, emit) async {
      if (event.search.isEmpty) {
        emit(BukuSearchInitial()); // Atau SearchLoaded([]) jika ingin kosong
        return;
      }
      emit(BukuSearchLoading());
      try {
        final books = await bukuRepository.getBooks(search: event.search);
        emit(BukuSearchLoaded(books));
      } catch (e) {
        emit(BukuSearchError(e.toString()));
      }
    });
  }
}
