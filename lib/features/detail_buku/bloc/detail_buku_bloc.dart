import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_buku_event.dart';
part 'detail_buku_state.dart';

class DetailBukuBloc extends Bloc<DetailBukuEvent, DetailBukuState> {
  DetailBukuBloc() : super(DetailBukuInitial()) {
    on<DetailBukuEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
