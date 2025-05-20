part of 'navigation_bloc.dart';

sealed class NavigationState {}

final class NavigationInitial extends NavigationState {}

final class NavigationLoaded extends NavigationState {
  final int index;
  NavigationLoaded({required this.index});
}
