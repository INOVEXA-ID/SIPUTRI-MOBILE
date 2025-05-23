import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/models/peminjaman_model.dart';
import 'package:siputri_mobile/features/bookshelf/api/bookshelf_api.dart';

part 'bookshelf_event.dart';
part 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  BookshelfBloc() : super(BookshelfLoading()) {
    on<FetchReadingList>((event, emit) async {
      emit(BookshelfLoading());
      try {
        final readingList = await BookshelfApi.getReadingList();
        emit(BookshelfLoaded(readingList));
      } catch (e) {
        emit(BookshelfError(e.toString()));
      }
    });
  }
}
