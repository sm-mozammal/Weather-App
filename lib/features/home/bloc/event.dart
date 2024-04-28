import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object?> get props => [];
}

class InitialCurrentWeatherEvent extends WeatherEvent {
  final String? lat;
  final String? lon;
  const InitialCurrentWeatherEvent({this.lat, this.lon});
}
