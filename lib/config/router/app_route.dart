import 'package:exploree_pal/features/auth/presentation/view/login_view.dart';
import 'package:exploree_pal/features/auth/presentation/view/register_view.dart';
import 'package:exploree_pal/features/home/presentation/view/about_places.dart';
import 'package:exploree_pal/features/splash/presentation/view/splash_screen_view.dart';

import '../../features/home/presentation/view/bottom_navigation.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String watchlistRoute = '/watchlists';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String aboutPlacesRoute = '/aboutPlaces';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashScreenView(),
      loginRoute: (context) => const LoginViews(),
      registerRoute: (context) => const RegisterViews(),
      dashboardRoute: (context) => const BottomNavView(),
      aboutPlacesRoute: (context) => const AboutPlaceView(),
    };
  }
}
