import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/bloc/tab_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/components/card_item_read.dart';
import 'package:siputri_mobile/features/bookshelf/components/card_item_history.dart';

class BookshelfScreen extends StatefulWidget {
  const BookshelfScreen({super.key});

  @override
  State<BookshelfScreen> createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  @override
  void initState() {
    super.initState();
    // Ambil data hanya jika belum pernah loaded
    final bookshelfBloc = context.read<BookshelfBloc>();
    if (bookshelfBloc.state is! BookshelfLoaded) {
      bookshelfBloc.add(FetchReadingList());
    }
    // History akan di-fetch saat tab ganti ke 1 (lihat handler tab di bawah)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          title: BlocBuilder<TabBloc, TabState>(
            builder: (context, state) {
              final selectedIndex =
                  state is TabChangeState ? state.selectedIndex : 0;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: BlocBuilder<TabBloc, TabState>(
          builder: (context, tabState) {
            final selectedIndex =
                tabState is TabChangeState ? tabState.selectedIndex : 0;
            if (selectedIndex == 0) {
              // Tab "Sedang Dibaca"
              return BlocBuilder<BookshelfBloc, BookshelfState>(
                builder: (context, bookshelfState) {
                  if (bookshelfState is BookshelfLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (bookshelfState is BookshelfLoaded) {
                    final readingList = bookshelfState.readingList;
                    if (readingList.isEmpty) {
                      return const Center(
                        child: Text("Belum ada buku yang sedang dibaca."),
                      );
                    }
                    return ListView.builder(
                      itemCount: readingList.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemBuilder: (context, index) {
                        final peminjaman = readingList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: CardItemRead(peminjaman: peminjaman),
                        );
                      },
                    );
                  } else if (bookshelfState is BookshelfError) {
                    return Center(child: Text(bookshelfState.message));
                  }
                  return const SizedBox();
                },
              );
            } else if (selectedIndex == 1) {
              // Tab "Riwayat"
              return BlocBuilder<BookshelfBloc, BookshelfState>(
                builder: (context, bookshelfState) {
                  if (bookshelfState is BookshelfHistoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (bookshelfState is BookshelfHistoryLoaded) {
                    final historyList = bookshelfState.historyList;
                    if (historyList.isEmpty) {
                      return const Center(
                        child: Text("Riwayat peminjaman kosong."),
                      );
                    }
                    return ListView.builder(
                      itemCount: historyList.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemBuilder: (context, index) {
                        final peminjaman = historyList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: CardItemHistory(peminjaman: peminjaman),
                        );
                      },
                    );
                  } else if (bookshelfState is BookshelfHistoryError) {
                    return Center(child: Text(bookshelfState.message));
                  }
                  return const SizedBox();
                },
              );
            }
            return Container();
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
          final bookshelfBloc = context.read<BookshelfBloc>();
          if (index == 1 &&
              bookshelfBloc.state is! BookshelfHistoryLoaded &&
              bookshelfBloc.state is! BookshelfHistoryLoading) {
            bookshelfBloc.add(FetchHistoryList());
          }
          if (index == 0 &&
              bookshelfBloc.state is! BookshelfLoaded &&
              bookshelfBloc.state is! BookshelfLoading) {
            bookshelfBloc.add(FetchReadingList());
          }
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
