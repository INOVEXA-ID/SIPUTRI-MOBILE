part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class ProfileUpdated extends ProfileEvent {
  final User user;
  ProfileUpdated(this.user);
}
