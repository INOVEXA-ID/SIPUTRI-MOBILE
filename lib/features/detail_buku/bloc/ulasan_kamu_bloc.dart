import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/models/ulasan_kamu.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/ulasan_kamu_repository.dart';

part 'ulasan_kamu_event.dart';
part 'ulasan_kamu_state.dart';

class UlasanKamuBloc extends Bloc<UlasanKamuEvent, UlasanKamuState> {
  final UlasanKamuRepository ulasanKamuRepository;
  UlasanKamuBloc(this.ulasanKamuRepository) : super(UlasanKamuInitial()) {
    on<GetUlasanKamu>((event, emit) async {
      try {
        emit(UlasanKamuLoading());
        final ulasanKamu = await ulasanKamuRepository.getUlasanKamu(
          id: event.id,
        );
        emit(UlasanKamuLoaded(ulasanKamu));
      } catch (e) {
        emit(UlasanKamuFailed(e.toString()));
      }
    });

    on<UpdateUlasanKamu>((event, emit) async {
      try {
        emit(UlasanKamuLoading());
        final result = await ulasanKamuRepository.updateUlasanKamu(
          idUser: event.idUser,
          idBuku: event.idBuku,
          ulasan: event.ulasan,
          rating: event.rating,
        );
        emit(UlasanKamuLoaded(result));
      } catch (e) {
        log(e.toString());
        emit(UlasanKamuFailed(e.toString()));
      }
    });

    on<PostUlasanKamu>((event, emit) async {
      try {
        emit(UlasanKamuLoading());
        final result = await ulasanKamuRepository.postUlasanKamu(
          idUser: event.idUser,
          idBuku: event.idBuku,
          ulasan: event.ulasan,
          rating: event.rating,
        );
        emit(PostUlasanKamuLoaded(result));
      } catch (e) {
        log(e.toString());
        emit(PostUlasanKamuFailed(e.toString()));
      }
    });
  }
}
