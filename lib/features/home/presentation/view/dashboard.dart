import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/config/constants/app_textstyle_theme.dart';
import 'package:exploree_pal/features/home/presentation/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardView extends ConsumerStatefulWidget {
  const DashBoardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends ConsumerState<DashBoardView> {
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
        toolbarHeight: screenHeight * 0.15,
        backgroundColor: AppColors.appbarColors,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              "Home",
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
            )
          ],
        ),
      ),
    );
  }
}
