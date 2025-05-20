import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabChangeState(0)) {
    on<ChangeTab>((event, emit) {
      emit(TabChangeState(event.index));
    });
  }
}
