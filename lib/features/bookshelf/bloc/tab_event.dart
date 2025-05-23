part of 'tab_bloc.dart';

sealed class TabEvent {}

class ChangeTab extends TabEvent {
  final int index;
  ChangeTab(this.index);
}
