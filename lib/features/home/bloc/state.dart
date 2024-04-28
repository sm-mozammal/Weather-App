import 'package:equatable/equatable.dart';
import '../model/current_weather.dart';
import '../model/forecast_weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object?> get props => [];
}

class WeatherInitialState extends WeatherState {}

class DataFetchingErrorState extends WeatherState {
  final String massage;
  const DataFetchingErrorState({required this.massage});

  @override
  List<Object?> get props => [massage];
}

class CurrentDataFetchState extends WeatherState {
  final CurrentWeather currentWeather;
  final ForecastWeather forecastWeather;
  const CurrentDataFetchState({required this.currentWeather, required this.forecastWeather});

  @override
  List<Object?> get props => [currentWeather, forecastWeather];
}

// class ForecastDataFetchState extends WeatherState {
//   final ForecastWeather forecastWeather;
//   const ForecastDataFetchState({required this.forecastWeather});
//
//   @override
//   List<Object?> get props => [forecastWeather];
// }
