import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_state.dart';
import '../bloc/auth_event.dart';
import '../data/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, isFailure: false));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, isFailure: false));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(
        state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false),
      );
      try {
        final user = await authRepository.login(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true, user: user));
      } catch (e) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isFailure: true,
            errorMessage: e.toString().replaceFirst('Exception: ', ''),
          ),
        );
      }
    });
  }
}
