part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherInit extends WeatherEvent {
  final String lat;
  final String lon;

  const WeatherInit({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon];
}
