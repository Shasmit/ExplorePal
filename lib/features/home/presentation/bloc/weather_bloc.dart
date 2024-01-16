import 'package:equatable/equatable.dart';
import 'package:exploree_pal/features/home/domain/entity/weather_details.dart';
import 'package:exploree_pal/features/home/domain/use_case/weather_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherBloc({required this.getWeatherUseCase}) : super(WeatherInitial()) {
    on<WeatherInit>(
      (event, emit) async {
        final result = await getWeatherUseCase(event.lat, event.lon);

        result.fold(
          (l) {
            emit(
              WeatherError(
                message: l.error,
                snackBar: const SnackBar(
                  content: Text('Could not load weather details'),
                ),
              ),
            );
          },
          (r) {
            emit(
              WeatherLoaded(weatherDetails: r),
            );
          },
        );
      },
    );
  }
}
