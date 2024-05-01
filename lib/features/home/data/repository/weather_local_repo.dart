import 'package:hive/hive.dart';

import '../../model/current_weather.dart';
import '../../model/forecast_weather.dart';

// Define Hive type adapters for CurrentWeather and ForecastWeather
class CurrentWeatherAdapter extends TypeAdapter<CurrentWeather> {
  @override
  final int typeId = 0;

  @override
  CurrentWeather read(BinaryReader reader) {
    return CurrentWeather.fromJson(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, CurrentWeather obj) {
    writer.writeMap(obj.toJson());
  }
}

class ForecastWeatherAdapter extends TypeAdapter<ForecastWeather> {
  @override
  final int typeId = 1;

  @override
  ForecastWeather read(BinaryReader reader) {
    return ForecastWeather.fromJson(
        Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, ForecastWeather obj) {
    writer.writeMap(obj.toJson());
  }
}

//Open Hive box and implement save and retrieve methods in WeatherLocalRepo
class WeatherLocalRepo {
  static const String _currentWeatherBoxName = 'current_weather';
  static const String _forecastWeatherBoxName = 'forecast_weather';

  static Future<Box> _openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  static Future<void> saveCurrentWeather(CurrentWeather currentWeather) async {
    final box = await _openBox(_currentWeatherBoxName);
    await box.put('current', currentWeather.toJson());
  }

  static Future<void> saveForecastWeather(
      ForecastWeather forecastWeather) async {
    final box = await _openBox(_forecastWeatherBoxName);
    await box.put('forecast', forecastWeather.toJson());
  }

  static Future<CurrentWeather?> getCurrentWeather() async {
    final box = await _openBox(_currentWeatherBoxName);
    final map = box.get('current');
    return map != null ? CurrentWeather.fromJson(map) : null;
  }

  Future<ForecastWeather?> getForecastWeather() async {
    final box = await _openBox(_forecastWeatherBoxName);
    final map = box.get('forecast');
    return map != null ? ForecastWeather.fromJson(map) : null;
  }
}
