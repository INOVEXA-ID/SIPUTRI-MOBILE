import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/models/detail_buku_model.dart';
import 'package:siputri_mobile/features/detail_buku/repositories/detail_buku_repository.dart';

part 'detail_buku_event.dart';
part 'detail_buku_state.dart';

class DetailBukuBloc extends Bloc<DetailBukuEvent, DetailBukuState> {
  final DetailBukuRepository detailBukuRepository;
  DetailBukuBloc(this.detailBukuRepository) : super(DetailBukuInitial()) {
    on<GetDetailBuku>((event, emit) async {
      emit(DetailBukuLoading());
      try {
        final books = await detailBukuRepository.getDetailBooks(id: event.id);
        emit(DetailBukuLoaded(books));
      } catch (e) {
        emit(DetailBukuFailed(e.toString()));
      }
    });
  }
}
