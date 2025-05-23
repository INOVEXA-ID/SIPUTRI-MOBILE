import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/core/helper/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    // Load profile dari local storage
    on<LoadProfile>((event, emit) {
      final user = TokenStorage().user;
      if (user != null) {
        emit(ProfileState.fromUser(user));
      }
    });

    // Event untuk update profile setelah edit
    on<ProfileUpdated>((event, emit) {
      emit(ProfileState.fromUser(event.user));
    });
  }
}
