import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  String searchValue = "";
  NavigationBloc() : super(NavigationLoaded(index: 0)) {
    on<ChangeTab>((event, emit) {
      emit(NavigationLoaded(index: event.index));
    });
  }
}
