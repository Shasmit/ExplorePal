import 'package:exploree_pal/features/home/domain/use_case/places_use_case.dart';
import 'package:exploree_pal/features/home/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../features/home/data/dataSource/weather_data_source.dart';
import '../../../features/home/data/repository/place_repo_impl.dart';
import '../../../features/home/data/repository/weather_repo_impl.dart';
import '../../../features/home/domain/repository/places_repository.dart';
import '../../../features/home/domain/repository/weather_repo.dart';
import '../../../features/home/domain/use_case/weather_usecase.dart';
import '../../../features/home/presentation/bloc/place_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  injectPlaces();
  injectWeather();
}

void injectPlaces() {
  sl.registerFactory<PlaceDetailsBloc>(
    () => PlaceDetailsBloc(
      getPlaceDetailsUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
      () => GetPlaceDetailsUseCase(placesRepository: sl()));

  sl.registerLazySingleton<PlacesRepository>(
    () => PlaceDetailsRepoImpl(),
  );
}

void injectWeather() {
  sl.registerFactory<WeatherBloc>(
    () => WeatherBloc(
      getWeatherUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
      () => GetWeatherUseCase(weatherDetailsRepository: sl()));

  sl.registerLazySingleton<WeatherDetailsRepository>(
    () => WeatherDetailsRepositoryImpl(weatherDataSource: sl()),
  );

  sl.registerLazySingleton<WeatherDataSource>(
    () => WeatherDataSourceImpl(),
  );
}
