import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/features/home/components/book_card.dart';
import 'package:siputri_mobile/features/search/bloc/buku_search_bloc.dart';
import 'package:siputri_mobile/features/search/components/empty.dart';
import 'package:siputri_mobile/features/search/components/welcome.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          title: Container(
            margin: EdgeInsets.only(top: 12),
            height: 40,
            child: TextField(
              controller: searchC,
              onSubmitted: (value) {
                context.read<BukuSearchBloc>().add(LoadSearchBuku(value));
              },
              decoration: InputDecoration(
                hintText: 'Cari buku',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<BukuSearchBloc, BukuSearchState>(
        builder: (context, state) {
          if (state is BukuSearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BukuSearchError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is BukuSearchLoaded) {
            if (state.buku.data.isEmpty) {
              return EmptySearch();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(Y: 2),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(const Duration(seconds: 1));
                      },
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.67,
                            ),
                        itemCount: state.buku.data.length,
                        itemBuilder: (context, index) {
                          final book = state.buku.data[index];
                          return InkWell(
                            // onTap:
                            //     () => Navigator.pushNamed(
                            //       context,
                            //       AppRouter.pdfRenderPage,
                            //     ),
                            child: BookCard(
                              title: book.judul,
                              description: book.deskripsi,
                              thumbnail:
                                  "${ApiConstants.baseUrlImage}/${book.thumbnail}",
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return WelcomeSearch();
          }
        },
      ),
    );
  }
}
