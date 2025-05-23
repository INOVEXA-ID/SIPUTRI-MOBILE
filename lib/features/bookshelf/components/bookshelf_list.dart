import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/bookshelf/components/card_item_read.dart';
import 'package:siputri_mobile/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:siputri_mobile/features/home/models/buku_model.dart';

class BookshelfList extends StatelessWidget {
  const BookshelfList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfBloc, BookshelfState>(
      builder: (context, state) {
        if (state is BookshelfLoaded) {
          final readingList = state.readingList;
          if (readingList.isEmpty) {
            return Center(child: Text("Belum ada buku yang sedang dibaca."));
          }
          return ListView.builder(
            itemCount: readingList.length,
            itemBuilder: (context, index) {
              final book = readingList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: CardItemRead(book: book),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
