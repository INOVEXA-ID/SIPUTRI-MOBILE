part of 'bookshelf_bloc.dart';

abstract class BookshelfEvent {}

class AddBookToReading extends BookshelfEvent {
  final Datum book;
  AddBookToReading(this.book);
}
