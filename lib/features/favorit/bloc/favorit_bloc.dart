import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/favorit/models/favorit_model.dart';
import 'package:siputri_mobile/features/favorit/repositories/favorit_repository.dart';

part 'favorit_event.dart';
part 'favorit_state.dart';

class FavoritBloc extends Bloc<FavoritEvent, FavoritState> {
  final FavoritRepository favoritRepository;
  FavoritBloc(this.favoritRepository) : super(FavoritInitial()) {
    on<GetFavorit>((event, emit) async {
      try {
        emit(FavoritLoading());
        final favorit = await favoritRepository.getFavorit();
        emit(FavoritLoaded(favorit));
      } catch (e) {
        emit(FavoritFailed(e.toString()));
      }
    });
  }
}
