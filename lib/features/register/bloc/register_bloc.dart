import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/register/repositories/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        await authRepository.register(
          nim: event.nim,
          nama: event.nama,
          jenisKelamin: event.jenisKelamin,
          telepon: event.telepon,
          alamat: event.alamat,
          email: event.email,
          password: event.password,
          passwordConfirmation: event.passwordConfirmation,
        );
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
