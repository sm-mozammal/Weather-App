import 'dart:developer';

import 'package:weather_app/features/home/model/forecast_weather.dart';

import '../../../../networks/dao/db_init.dart';
import '../../../../networks/db_table_constants.dart';
import '../../../../networks/exception_handler/data_source.dart';

class WeatherLocalRepository {
  static final WeatherLocalRepository _singleton =
      WeatherLocalRepository._internal();

  WeatherLocalRepository._internal();

  static WeatherLocalRepository get instance => _singleton;
  Future<ForecastWeather> getForecast() async {
    try {
      List<Map<String, dynamic>> resultdata =
          await getAllData(TableConst.kForcastTableName);
      final forecastList =
          resultdata.map((map) => ForecastWeather.fromJson(map)).toList();
      log('local data fetch: $resultdata');
      return forecastList.first;
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }

  void saveData(List<Map<String, dynamic>> forecastWeather) {
    insertBatchData(
        table: TableConst.kForcastTableName, entities: forecastWeather);
  }
}
