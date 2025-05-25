part of 'bookshelf_bloc.dart';

abstract class BookshelfEvent {}

class FetchReadingList extends BookshelfEvent {}

class FetchHistoryList extends BookshelfEvent {}
