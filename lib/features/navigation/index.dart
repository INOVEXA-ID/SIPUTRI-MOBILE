import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'package:siputri_mobile/features/home/index.dart';
import 'package:siputri_mobile/features/navigation/bloc/navigation_bloc.dart';

class NavigationBarPage extends StatelessWidget {
  const NavigationBarPage({super.key});

  final List<Widget> _pages = const [
    HomeScreen(),
    Text('Cari'),
    Text('Favorit'),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationLoaded) {
          currentIndex = state.index;
        }
        return Scaffold(
          body: _pages[currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: GNav(
              selectedIndex: currentIndex,
              onTabChange: (value) {
                context.read<NavigationBloc>().add(ChangeTab(value));
              },
              iconSize: 22,
              style: GnavStyle.google,
              tabBorderRadius: 40,
              color: Colors.grey,
              activeColor: ColorConstants.primaryColor,
              tabBackgroundColor: ColorConstants.primaryColor_400,
              gap: 4,
              padding: const EdgeInsets.all(12),
              textSize: 11,
              duration: Duration(milliseconds: 500),
              tabMargin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              tabs: [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.search, text: 'Cari'),
                GButton(icon: Icons.favorite_border, text: 'Favorit'),
                GButton(icon: Icons.person, text: 'Profile'),
              ],
            ),
          ),
        );
      },
    );
  }
}
