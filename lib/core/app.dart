import 'package:exploree_pal/config/router/app_route.dart';
import 'package:exploree_pal/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ExplorePal',
      theme: AppThemes.getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoute(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
