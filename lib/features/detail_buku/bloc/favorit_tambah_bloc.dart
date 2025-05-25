import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/favorit_detail_buku_repository.dart';

part 'favorit_tambah_event.dart';
part 'favorit_tambah_state.dart';

class FavoritTambahBloc extends Bloc<FavoritEvent, FavoritState> {
  final FavoritDetailBukuRepository favoritDetailBukuRepository;
  FavoritTambahBloc(this.favoritDetailBukuRepository)
    : super(FavoritInitial()) {
    on<PostFavoritEvent>((event, emit) async {
      try {
        emit(FavoritLoading());
        final response = await favoritDetailBukuRepository.postFavorit(
          idBuku: event.idBuku.toString(),
        );
        emit(FavoritSuccess(response));
      } catch (e) {
        emit(FavoritError(e.toString()));
      }
    });
  }
}
