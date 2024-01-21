import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/config/constants/app_textstyle_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/viewmodel/logout_view_model.dart';

class DrawerView extends ConsumerStatefulWidget {
  const DrawerView({super.key});

  @override
  ConsumerState<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends ConsumerState<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.buttonColors,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          bottom: 0.0,
          right: 0.0,
          left: 16.0,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ExplorePal',
                      style: AppTextStyle.poppinsMedium20.copyWith(
                        color: AppColors.bodyColors,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            tiles(
              'Log-Out',
              Icons.logout_rounded,
              () {
                ref.read(logoutViewModelProvider.notifier).logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget tiles(String tileName, IconData icon, void Function() onTap) {
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        tileName,
        style: AppTextStyle.poppinsMedium15.copyWith(
          color: AppColors.bodyColors,
        ),
      ),
      onTap: onTap,
    );
  }
}
