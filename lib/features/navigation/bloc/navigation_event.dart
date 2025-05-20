part of 'navigation_bloc.dart';

sealed class NavigationEvent {}

class ChangeTab extends NavigationEvent {
  final int index;
  ChangeTab(this.index);
}
