import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/config/app_router.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/core/widgets/my_text.dart';
import 'package:siputri_mobile/core/widgets/user_avatar.dart';
import 'package:siputri_mobile/features/home/models/buku_dibaca_model.dart';
import 'package:siputri_mobile/profile/bloc/profile_bloc.dart';
import 'package:siputri_mobile/features/navigation/bloc/navigation_bloc.dart';
import 'package:siputri_mobile/features/search/bloc/buku_search_bloc.dart';
import 'package:siputri_mobile/profile/profile_screen.dart';

class AppBarHome extends StatelessWidget {
  bool isReading = false;
  BukuDibacaModel? bukuDibaca;
  AppBarHome({super.key, required this.isReading, this.bukuDibaca});
  final user = TokenStorage().user;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blue.shade700,
      elevation: 0,
      toolbarHeight: isReading ? 275 : 140,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (context) => ProfileBloc(),
                            child: const ProfileScreen(),
                          ),
                    ),
                  );
                },
                child: UserAvatar(size: 40),
              ),
              Gap(X: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${user?.nama}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Mau baca buku apa hari ini?',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!isReading) searchWidget(searchController, context),
          if (isReading)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: MyText(
                            title:
                                "Jangan lupa kamu masih belum punya buku yang masih belum selesai di baca.",
                            color: Colors.grey.shade600,
                            maxLine: 2,
                          ),
                        ),
                      ),
                    ),
                    Gap(Y: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: NetworkImage(
                                "${ApiConstants.baseUrlImage}/${bukuDibaca?.data!.buku.thumbnail}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap(X: 10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    title: bukuDibaca!.data!.buku.judul,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                    maxLine: 1,
                                    fontSize: 12,
                                  ),
                                  MyText(
                                    title: bukuDibaca!.data!.buku.penulis,
                                    color: Colors.grey.shade600,
                                    maxLine: 1,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                              Gap(Y: 35),
                              Material(
                                child: InkWell(
                                  onTap:
                                      () => Navigator.pushNamed(
                                        context,
                                        AppRouter.detailBukuPage,
                                        arguments: {
                                          'id':
                                              bukuDibaca!.data!.idBuku
                                                  .toString(),
                                        },
                                      ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: MyText(
                                        title: "Lanjutkan",
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  SizedBox searchWidget(
    TextEditingController searchController,
    BuildContext context,
  ) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: searchController,
        onSubmitted: (value) {
          context.read<NavigationBloc>().add(ChangeTab(1));

          // 2. Kirim query ke SearchBloc (pastikan SearchScreen-nya ada BlocProvider)
          context.read<BukuSearchBloc>().add(LoadSearchBuku(value));
        },
        decoration: InputDecoration(
          hintText: 'Cari buku',
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}
