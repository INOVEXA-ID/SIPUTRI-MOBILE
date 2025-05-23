import './export/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/components/card_item_read.dart';
import 'package:siputri_mobile/features/bookshelf/components/card_item_history.dart';
import 'package:siputri_mobile/features/home/models/buku_model.dart';

class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (_) => TabBloc(),
      child: Scaffold(
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
                      buildTab(
                        context,
                        index: 0,
                        icon: Icons.menu_book_rounded,
                        label: 'Sedang Dibaca',
                        selected: selectedIndex == 0,
                      ),
                      buildTab(
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
              switch (selectedIndex) {
                case 0:
                  // Tab "Sedang Dibaca"
                  return BlocBuilder<BookshelfBloc, BookshelfState>(
                    builder: (context, bookshelfState) {
                      if (bookshelfState is BookshelfLoaded) {
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
                            final book = readingList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: CardItemRead(book: book),
                            );
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                case 1:
                  // Tab "Riwayat" (masih dummy)
                  return ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: const CardItemHistory(),
                      );
                    },
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
