import 'dart:async';

import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/splash_viewmodel.dart';

class SplashScreenView extends ConsumerStatefulWidget {
  const SplashScreenView({super.key});

  @override
  ConsumerState<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends ConsumerState<SplashScreenView> {
  @override
  void initState() {
    // Wait for 2 seconds and then navigate
    Future.delayed(const Duration(seconds: 2), () {
      ref.read(splashViewModelProvider.notifier).init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bodyColors,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/explorepal.png",
              width: double.infinity,
              height: screenSize.height * 0.25,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              color: AppColors.buttonColors,
            )
          ],
        ),
      ),
    );
  }
}
