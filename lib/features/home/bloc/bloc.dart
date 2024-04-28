import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helpers/di.dart';
import '../data/repository/weather_repository.dart';
import '../model/current_weather.dart';
import '../model/forecast_weather.dart';
import 'event.dart';
import 'state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<InitialCurrentWeatherEvent>(fetchCurrentData);
    // on<InitialForecastWeatherEvent>(fetchForecastData);
  }

  FutureOr<void> fetchCurrentData(
      InitialCurrentWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      CurrentWeather currentData = await locator
          .get<WeatherRepository>()
          .getCurrentData(event.lat, event.lon);
      // log(currentData.toString());
      ForecastWeather forecastData = await locator
          .get<WeatherRepository>()
          .getForecastData(event.lat, event.lon);
      // log(forecastData.toString());
      emit(CurrentDataFetchState(
          currentWeather: currentData, forecastWeather: forecastData));
    } catch (error) {
      emit(DataFetchingErrorState(massage: error.toString()));
    }
  }

  // FutureOr<void> fetchForecastData(
  //     InitialForecastWeatherEvent event, Emitter<WeatherState> emit) async {
  //   try {
  //     ForecastWeather forecastData =
  //         await locator.get<WeatherRepository>().getForecastData(event.lat, event.lon);
  //     log(forecastData.toString());
  //     emit(ForecastDataFetchState(forecastWeather: forecastData));
  //   } catch (error) {
  //     emit(DataFetchingErrorState(massage: error.toString()));
  //   }
  // }
}
