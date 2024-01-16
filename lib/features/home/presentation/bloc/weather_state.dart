part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final String message;
  final SnackBar snackBar;
  const WeatherError({required this.message, required this.snackBar});
}

class WeatherLoaded extends WeatherState {
  final WeatherDetails weatherDetails;

  const WeatherLoaded({required this.weatherDetails});

  @override
  List<Object> get props => [weatherDetails];
}
