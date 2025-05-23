import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/home/models/buku_model.dart';

part 'bookshelf_event.dart';
part 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  BookshelfBloc() : super(BookshelfLoaded([])) {
    on<AddBookToReading>((event, emit) {
      if (state is BookshelfLoaded) {
        final currentList = List<Datum>.from(
          (state as BookshelfLoaded).readingList,
        );
        // Cegah duplikat
        if (!currentList.any((b) => b.idBuku == event.book.idBuku)) {
          currentList.add(event.book);
        }
        emit(BookshelfLoaded(currentList));
      }
    });
  }
}
