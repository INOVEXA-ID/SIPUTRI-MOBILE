part of 'bookshelf_bloc.dart';

abstract class BookshelfState {}

class BookshelfLoaded extends BookshelfState {
  final List<Datum> readingList;
  BookshelfLoaded(this.readingList);
}
