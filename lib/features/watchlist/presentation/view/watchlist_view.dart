import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_color_theme.dart';
import '../../../../config/constants/app_textstyle_theme.dart';
import '../../../home/presentation/widget/drawer.dart';

class WatchListView extends ConsumerStatefulWidget {
  const WatchListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatchListViewState();
}

class _WatchListViewState extends ConsumerState<WatchListView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerView(),
      backgroundColor: AppColors.bodyColors,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight * 0.25,
        backgroundColor: AppColors.appbarColors,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Image.asset(
                    "assets/icons/menu30.png",
                  ),
                ),
                Text(
                  "Bookmarks",
                  style: AppTextStyle.poppinsSemiBold22.copyWith(
                    color: AppColors.secondaryColors,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: .5,
                        blurRadius: 6,
                        offset: const Offset(.5, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.bodyColors,
                    foregroundImage: const AssetImage(
                      "assets/icons/user.png",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.035,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Bookmarked',
                    style: AppTextStyle.poppinsBold25,
                  ),
                  Text(
                    'Destinations',
                    style: AppTextStyle.poppinsSemiBold20.copyWith(
                      color: const Color(0xff6F7789),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
