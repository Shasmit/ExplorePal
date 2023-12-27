import 'package:exploree_pal/features/auth/presentation/view/login_view.dart';
import 'package:exploree_pal/features/auth/presentation/view/register_view.dart';
import 'package:exploree_pal/features/home/presentation/view/dashboard.dart';
import 'package:exploree_pal/features/splash/presentation/view/splash_screen_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String watchlistRoute = '/watchlists';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String movieRoute = '/movies';
  static const String editprofileRoute = '/edit';
  static const String profileRoute = '/profile';
  static const String updatePassword = '/update';
  static const String resetPassword = '/reset';
  static const String allReviews = '/allReviews';
  static const String movieScreen = '/movieScreen';
  static const String writeReview = '/writeReview';
  static const String updateReview = '/updateReview';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashScreenView(),
      loginRoute: (context) => const LoginViews(),
      registerRoute: (context) => const RegisterViews(),
      dashboardRoute: (context) => const DashBoardView(),
    };
  }
}
