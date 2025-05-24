import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 2));
      bool isLogedIn = TokenStorage().isLoggedIn ? true : false;
      log(TokenStorage().token.toString());
      emit(SplashLoaded(isLogedIn: isLogedIn));
    });
  }
}
