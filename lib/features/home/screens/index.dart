import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/config/app_router.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/features/home/bloc/buku_bloc.dart';
import 'package:siputri_mobile/features/home/bloc/buku_dibaca_bloc.dart';
import 'package:siputri_mobile/features/home/components/app_bar.dart';
import 'package:siputri_mobile/features/home/components/book_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double getAppBarHeight(BukuDibacaState state) {
    if (state is BukuDibacaLoaded && state.bukuDibacaModel.data != null) {
      return 275;
    }
    return 140;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BukuDibacaBloc>().state;
    final sizeHeight = getAppBarHeight(state);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight),
        child: BlocBuilder<BukuDibacaBloc, BukuDibacaState>(
          builder: (context, state) {
            if (state is BukuDibacaLoading) {
              return AppBarHome(isReading: false);
            } else if (state is BukuDibacaLoaded) {
              return AppBarHome(
                isReading: (state.bukuDibacaModel.data != null) ? true : false,
                bukuDibaca: state.bukuDibacaModel,
              );
            }
            return AppBarHome(isReading: false);
          },
        ),
      ),
      body: BlocBuilder<BukuBloc, BukuState>(
        builder: (context, state) {
          if (state is BukuLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BukuError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is BukuLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(Y: 2),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      context.read<BukuBloc>().add(LoadBuku());
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
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
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                AppRouter.detailBukuPage,
                                arguments: {'id': book.idBuku.toString()},
                              ),
                          child: BookCard(
                            title: book.judul,
                            description: book.deskripsi,
                            thumbnail: book.thumbnailUrl,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Tidak ada data'));
          }
        },
      ),
    );
  }
}
