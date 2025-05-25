import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/features/search/bloc/buku_search_bloc.dart';
import 'package:siputri_mobile/features/search/components/card_item_serach.dart';
import 'package:siputri_mobile/features/search/components/empty.dart';
import 'package:siputri_mobile/features/search/components/welcome.dart'; // Import CardItems favorit

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchC = TextEditingController();

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BukuSearchBloc, BukuSearchState>(
      listenWhen: (previous, current) => current is BukuSearchLoaded,
      listener: (context, state) {
        if (state is BukuSearchLoaded) {
          searchC.text = state.searchVal.toString();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: ColorConstants.primaryColor,
            title: Container(
              margin: const EdgeInsets.only(top: 12),
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
              return const Center(child: CircularProgressIndicator());
            } else if (state is BukuSearchError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is BukuSearchLoaded) {
              if (state.buku.data.isEmpty) {
                return const EmptySearch();
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemCount: state.buku.data.length,
                  itemBuilder: (context, index) {
                    final book = state.buku.data[index];
                    // Pastikan image tidak double domain, dan fallback jika null/kosong
                    final thumbnailUrl = book.thumbnailUrl;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CardItemSearch(
                        title: book.judul,
                        penulis: book.penulis,
                        rating: book.rating,
                        description: book.deskripsi,
                        image:
                            (thumbnailUrl != null && thumbnailUrl.isNotEmpty)
                                ? thumbnailUrl
                                : 'assets/images/4.jpeg',
                        jmlUlasan: 0, // Isi sesuai field jika ada di model
                        jmlPembaca:
                            0, // Isi sesuai field jika ada di model, // Kosongkan jika tidak ada
                        jmlBuku: book.jumlahBuku,
                        tersedia:
                            book.jumlahBuku, // Atau field sesuai data tersedia
                      ),
                    );
                  },
                );
              }
            } else {
              return const WelcomeSearch();
            }
          },
        ),
      ),
    );
  }
}
