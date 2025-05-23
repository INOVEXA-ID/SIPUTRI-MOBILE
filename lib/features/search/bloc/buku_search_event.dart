part of 'buku_search_bloc.dart';

sealed class BukuSearchEvent {}

class LoadSearchBuku extends BukuSearchEvent {
  final String search;
  LoadSearchBuku(this.search);
}
