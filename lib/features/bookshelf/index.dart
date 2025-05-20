import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/bloc/tab_bloc.dart';

class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (_) => TabBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            elevation: 0,
            toolbarHeight: 100,
            backgroundColor: Colors.white,
            title: BlocBuilder<TabBloc, TabState>(
              builder: (context, state) {
                final selectedIndex =
                    state is TabChangeState ? state.selectedIndex : 0;
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 3,
                        spreadRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _buildTab(
                        context,
                        index: 0,
                        icon: Icons.menu_book_rounded,
                        label: 'Sedang Dibaca',
                        selected: selectedIndex == 0,
                      ),
                      _buildTab(
                        context,
                        index: 1,
                        icon: Icons.book_rounded,
                        label: 'Riwayat',
                        selected: selectedIndex == 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        body: BlocBuilder<TabBloc, TabState>(
          builder: (context, state) {
            final selectedIndex =
                state is TabChangeState ? state.selectedIndex : 0;
            // Ganti tampilan berdasarkan tab yang aktif
            switch (selectedIndex) {
              case 0:
                return Text("Sedang Dibaca"); // Widget buatan kamu
              case 1:
                return Text("Riwayat"); // Widget buatan kamu
              default:
                return Container(); // Fallback
            }
          },
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool selected,
  }) {
    final color = selected ? Colors.blue : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<TabBloc>().add(ChangeTab(index));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 13)),
            if (selected)
              Container(
                margin: const EdgeInsets.only(top: 6),
                height: 3,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
