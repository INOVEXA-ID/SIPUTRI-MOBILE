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

class BookshelfHistoryLoading extends BookshelfState {}

class BookshelfHistoryLoaded extends BookshelfState {
  final List<PeminjamanModel> historyList;
  BookshelfHistoryLoaded(this.historyList);
}

class BookshelfHistoryError extends BookshelfState {
  final String message;
  BookshelfHistoryError(this.message);
}
