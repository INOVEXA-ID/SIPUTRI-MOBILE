import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:siputri_mobile/features/bookshelf/bloc/bookshelf_bloc.dart';

abstract class TabEvent {}

class ChangeTab extends TabEvent {
  final int selectedIndex;
  ChangeTab(this.selectedIndex);
}

abstract class TabState {}

class TabInitial extends TabState {
  final int selectedIndex;
  TabInitial(this.selectedIndex);
}

class TabChangeState extends TabState {
  final int selectedIndex;
  TabChangeState(this.selectedIndex);
}

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial(0)) {
    on<ChangeTab>((event, emit) {
      emit(TabChangeState(event.selectedIndex));
    });
  }
}

Widget buildTab(
  BuildContext context, {
  required int index,
  required IconData icon,
  required String label,
  required bool selected,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        context.read<TabBloc>().add(ChangeTab(index));
        // Trigger fetch event for history if needed
        if (index == 1) {
          context.read<BookshelfBloc>().add(FetchHistoryList());
        } else if (index == 0) {
          context.read<BookshelfBloc>().add(FetchReadingList());
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? Colors.blue : Colors.grey),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? Colors.blue : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
