class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3001/";
  static const String baseUrl = "http://192.168.137.1:3001/";

  static const String weatherUrl = "open-weather13.p.rapidapi.com";

  // ====================== Auth Routes ======================
  static const String login = "users/login";
  static const String register = "users/register";
  static const String verifyUser = "users/";
  static const String changePassword = "users/change-password";
  static const String uploadImage = "users/uploadImage";
  static const String updateProfile = "users/edit-profile";

  //======================== Watchlist Routes =====================
  static const String createWatchlist = "watchlist/";
  static const String deleteWatchlist = "watchlist/";
  static const String getWatchlist = "watchlist/";
}
