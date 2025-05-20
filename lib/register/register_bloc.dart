import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    on<NimChanged>((event, emit) => emit(state.copyWith(nim: event.nim)));
    on<NamaChanged>((event, emit) => emit(state.copyWith(nama: event.nama)));
    on<JenisKelaminChanged>(
      (event, emit) => emit(state.copyWith(jenisKelamin: event.jenisKelamin)),
    );
    on<TeleponChanged>(
      (event, emit) => emit(state.copyWith(telepon: event.telepon)),
    );
    on<AlamatChanged>(
      (event, emit) => emit(state.copyWith(alamat: event.alamat)),
    );
    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );

    on<RegisterSubmitted>((event, emit) async {
      emit(
        state.copyWith(isSubmitting: true, isSuccess: false, isFailure: false),
      );
      await Future.delayed(const Duration(seconds: 1)); // Simulasi register
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
