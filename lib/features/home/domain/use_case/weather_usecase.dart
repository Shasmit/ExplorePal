import 'package:dartz/dartz.dart';
import 'package:exploree_pal/core/failure/failure.dart';
import 'package:exploree_pal/features/home/domain/entity/weather_details.dart';

import '../repository/weather_repo.dart';

class GetWeatherUseCase {
  final WeatherDetailsRepository weatherDetailsRepository;

  GetWeatherUseCase({required this.weatherDetailsRepository});

  Future<Either<Failure, WeatherDetails>> call(String lat, String lon) async {
    return await weatherDetailsRepository.getWeatherDetails(lat, lon);
  }
}
