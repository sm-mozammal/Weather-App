import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/features/home/data/repository/local_repository.dart';
import 'package:weather_app/networks/dao/db_init.dart';
import '../features/home/data/repository/weather_repository.dart';
import '../networks/dio/dio.dart';

final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

void diSetup() {
  locator.registerSingleton<GetStorage>(GetStorage());
  locator.registerSingleton<DioSingleton>(DioSingleton.instance);
  locator.registerSingleton<DbSingleton>(DbSingleton.instance);

  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepository.instance);
  locator.registerLazySingleton<WeatherLocalRepository>(
      () => WeatherLocalRepository.instance);
}
