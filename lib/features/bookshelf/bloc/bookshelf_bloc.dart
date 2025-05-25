import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/models/peminjaman_model.dart';
import 'package:siputri_mobile/features/bookshelf/repository/peminjaman_buku_repository.dart';

part 'bookshelf_event.dart';
part 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  final PeminjamanBukuRepository peminjamanRepository;

  BookshelfBloc({required this.peminjamanRepository})
    : super(BookshelfLoading()) {
    on<FetchReadingList>((event, emit) async {
      emit(BookshelfLoading());
      try {
        final readingList = await peminjamanRepository.getSedangDibacaList();
        emit(BookshelfLoaded(readingList));
      } catch (e) {
        emit(BookshelfError(e.toString()));
      }
    });

    on<FetchHistoryList>((event, emit) async {
      emit(BookshelfHistoryLoading());
      try {
        final historyList =
            await peminjamanRepository.getRiwayatPeminjamanList();
        emit(BookshelfHistoryLoaded(historyList));
      } catch (e) {
        emit(BookshelfHistoryError(e.toString()));
      }
    });
  }
}
