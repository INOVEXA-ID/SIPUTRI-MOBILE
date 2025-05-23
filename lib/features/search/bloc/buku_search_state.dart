part of 'buku_search_bloc.dart';

sealed class BukuSearchState {}

class BukuSearchInitial extends BukuSearchState {}

class BukuSearchLoading extends BukuSearchState {}

class BukuSearchLoaded extends BukuSearchState {
  final BukuSearchModel buku;
  String searchVal = '';
  BukuSearchLoaded(this.buku, this.searchVal);
}

class BukuSearchError extends BukuSearchState {
  final String message;
  BukuSearchError(this.message);
}
