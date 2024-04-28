import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/current_weather.dart';
import '../../model/forecast_weather.dart';

class WeatherRepository {
  static final WeatherRepository _singleton = WeatherRepository._internal();

  WeatherRepository._internal();

  static WeatherRepository get instance => _singleton;

  Future<CurrentWeather> getCurrentData(String? lat, String? lon) async {
    try {
      Response response = await getHttp(Endpoints.currentWeather(lat, lon));
      if (response.statusCode == 200) {
        CurrentWeather jsonData = CurrentWeather.fromJson(response.data);
        return jsonData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      throw ErrorHandler.handle(e).failure;
    }
  }

  Future<ForecastWeather> getForecastData(String? lat, String? lon) async {
    try {
      Response response = await getHttp(Endpoints.forcastWeather(lat, lon));
      if (response.statusCode == 200) {
        ForecastWeather jsonData = ForecastWeather.fromJson(response.data);
        return jsonData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      throw ErrorHandler.handle(e).failure;
    }
  }
}
