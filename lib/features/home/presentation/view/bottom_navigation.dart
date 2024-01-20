import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/features/home/presentation/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../watchlist/presentation/view/watchlist_view.dart';

class BottomNavView extends ConsumerStatefulWidget {
  const BottomNavView({super.key});

  @override
  ConsumerState<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends ConsumerState<BottomNavView> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 0;
  final screens = [
    const DashBoardView(),
    const WatchListView(),
    const DashBoardView(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      CrystalNavigationBarItem(
        icon: Icons.home_filled,
        unselectedIcon: Icons.home_outlined,
        selectedColor: AppColors.bodyColors,
        unselectedColor: Colors.white60,
      ),
      CrystalNavigationBarItem(
        icon: Icons.bookmark,
        unselectedIcon: Icons.bookmark_outline_outlined,
        selectedColor: AppColors.bodyColors,
        unselectedColor: Colors.white60,
      ),
      CrystalNavigationBarItem(
        icon: Icons.person,
        unselectedIcon: Icons.person_2_outlined,
        selectedColor: AppColors.bodyColors,
        unselectedColor: Colors.white60,
      ),
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CrystalNavigationBar(
        marginR: const EdgeInsets.all(20),
        enableFloatingNavBar: true,
        curve: Curves.easeIn,
        paddingR: const EdgeInsets.only(
          bottom: 10,
          top: 5,
          right: 10,
          left: 10,
        ),
        borderRadius: 20,
        items: items,
        onTap: (index) => setState(() => this.index = index),
        currentIndex: index,
        backgroundColor: AppColors.buttonNavBarColors,
        height: 60,
      ),
    );
  }
}

// Theme(
//         data: Theme.of(context).copyWith(
//           iconTheme: IconThemeData(
//             color: AppColors.buttonNavBarColors,
//           ),
//         ),
//         child: CurvedNavigationBar(
//           key: navigationKey,
//           color: AppColors.buttonNavBarColors,
//           buttonBackgroundColor: Colors.white,
//           backgroundColor: Colors.transparent,
//           height: 60,
//           index: index,
//           items: items,
//           onTap: (index) => setState(() => this.index = index),
//         ),
//       ),