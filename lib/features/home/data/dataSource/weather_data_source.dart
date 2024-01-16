import 'dart:convert';

import 'package:exploree_pal/core/network/https_services.dart';
import 'package:exploree_pal/features/home/domain/entity/weather_details.dart';

abstract class WeatherDataSource {
  Future<WeatherDetails> getWeatherDetails(String lat, String lon);
}

class WeatherDataSourceImpl extends WeatherDataSource {
  HttpsServices httpsServices = HttpsServices();

  @override
  Future<WeatherDetails> getWeatherDetails(String lat, String lon) async {
    final response = await httpsServices.getWeatherDetails(lat, lon);

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(WeatherDetails.fromJson(result));
      return WeatherDetails.fromJson(result);
    } else {
      throw Exception("Error fetching weather details");
    }
  }
}
