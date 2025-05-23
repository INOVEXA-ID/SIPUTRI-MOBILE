import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/config/app_router.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/core/widgets/pdf_thumbnail.dart';
import 'package:siputri_mobile/features/home/bloc/buku_bloc.dart';
import 'package:siputri_mobile/features/home/components/app_bar.dart';
import 'package:siputri_mobile/features/home/components/book_card.dart';
import 'package:siputri_mobile/features/home/repositories/buku_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => BukuBloc(BukuRepository(DioClient()))..add(LoadBuku()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: AppBarHome(),
        ), // AppBar(),
        body: BlocBuilder<BukuBloc, BukuState>(
          builder: (context, state) {
            if (state is BukuLoading) {
              return Center(child: CircularProgressIndicator());
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
                            onTap:
                                () => Navigator.pushNamed(
                                  context,
                                  AppRouter.pdfRenderPage,
                                ),
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
            } else {
              return Center(child: Text('Tidak ada data'));
            }
          },
        ),
      ),
    );
  }
}
