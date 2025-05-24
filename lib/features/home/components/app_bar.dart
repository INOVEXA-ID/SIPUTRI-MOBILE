import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/core/widgets/user_avatar.dart';
import 'package:siputri_mobile/profile/bloc/profile_bloc.dart';
import 'package:siputri_mobile/features/navigation/bloc/navigation_bloc.dart';
import 'package:siputri_mobile/features/search/bloc/buku_search_bloc.dart';
import 'package:siputri_mobile/profile/profile_screen.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final user = TokenStorage().user;
    final TextEditingController searchController = TextEditingController();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blue.shade700,
      elevation: 0,
      toolbarHeight: 140,
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
          SizedBox(
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
        ],
      ),
    );
  }
}
