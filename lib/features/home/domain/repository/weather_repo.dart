import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entity/weather_details.dart';

abstract class WeatherDetailsRepository {
  Future<Either<Failure, WeatherDetails>> getWeatherDetails(
      String lat, String lon);
}
