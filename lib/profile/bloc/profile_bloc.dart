import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<LoadProfile>((event, emit) {
      // Bisa kamu ganti dengan data dari backend atau lokal
      emit(
        ProfileState(
          nama: 'Kristopir',
          nim: '1234567890',
          jenisKelamin: 'Perempuan',
          noHp: '08123456789',
          alamat: 'Jl. Melati No. 10',
          email: 'kristopir@example.com',
        ),
      );
    });
  }
}
