import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/edit_profile/bloc/edit_profile_event.dart';
import 'package:siputri_mobile/edit_profile/bloc/edit_profile_state.dart';
import 'package:siputri_mobile/edit_profile/repositories/profile_repository.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository profileRepository;

  EditProfileBloc(this.profileRepository) : super(EditProfileInitial()) {
    on<EditProfileSubmitted>((event, emit) async {
      emit(EditProfileLoading());
      try {
        await profileRepository.updateProfile(
          nama: event.nama,
          telepon: event.telepon,
          alamat: event.alamat,
          jenisKelamin: event.jenisKelamin,
          foto: event.foto,
        );
        emit(EditProfileSuccess());
      } catch (e) {
        emit(EditProfileFailure(e.toString()));
      }
    });
  }
}
