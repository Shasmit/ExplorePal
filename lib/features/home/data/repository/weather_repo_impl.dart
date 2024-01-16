import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exploree_pal/core/failure/failure.dart';
import 'package:exploree_pal/features/home/domain/entity/weather_details.dart';
import 'package:exploree_pal/features/home/domain/repository/weather_repo.dart';

import '../dataSource/weather_data_source.dart';

class WeatherDetailsRepositoryImpl implements WeatherDetailsRepository {
  final WeatherDataSource weatherDataSource;

  WeatherDetailsRepositoryImpl({required this.weatherDataSource});

  @override
  Future<Either<Failure, WeatherDetails>> getWeatherDetails(
      String lat, String lon) async {
    try {
      final response = await weatherDataSource.getWeatherDetails(lat, lon);
      return Right(response);
    } on DioException catch (e) {
      print('ssssssssssss');
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
