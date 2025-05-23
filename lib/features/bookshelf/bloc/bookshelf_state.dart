part of 'bookshelf_bloc.dart';

abstract class BookshelfState {}

class BookshelfLoading extends BookshelfState {}

class BookshelfLoaded extends BookshelfState {
  final List<PeminjamanModel> readingList;
  BookshelfLoaded(this.readingList);
}

class BookshelfError extends BookshelfState {
  final String message;
  BookshelfError(this.message);
}
