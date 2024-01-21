import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String? imageUrl;

  const ImageView({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            decoration: BoxDecoration(
          color: AppColors.bodyColors,
          image: DecorationImage(
            image: NetworkImage(imageUrl ??
                'https://radianttreks.com/wp-content/uploads/2020/04/Best-time-to-visit-Rara-Lake.jpg'),
            fit: BoxFit.contain,
          ),
        )),
      ),
    );
  }
}
