part of 'tab_bloc.dart';

sealed class TabState {}

class TabChangeState extends TabState {
  final int selectedIndex;
  TabChangeState(this.selectedIndex);
}
