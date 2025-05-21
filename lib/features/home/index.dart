import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/config/app_router.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/features/home/components/app_bar.dart';
import 'package:siputri_mobile/features/home/components/book_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBarHome(),
      ), // AppBar(),
      body: Column(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.67,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          AppRouter.pdfRenderPage,
                        ),
                    child: BookCard(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
