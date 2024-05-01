import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/home/bloc/bloc.dart';
import 'package:weather_app/helpers/register_provider.dart';
import 'features/home/presentation/home_screen.dart';
import 'helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'networks/dao/db_init.dart';
import 'networks/dio/dio.dart';

void main() async {
  await GetStorage.init();
  diSetup();
  initInternetChecker();
  DioSingleton.instance.create();
  await DbSingleton.instance.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    getLocation();
    return ScreenUtilInit(
        designSize: const Size(375, 838),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              showMaterialDialog(context);
            },
            child: MultiBlocProvider(
              providers: [
                BlocProvider<WeatherBloc>(
                  create: (_) => WeatherBloc(),
                ),
              ],
              child: MultiProvider(
                providers: providers,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Weather App',
                  theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                  ),
                  onGenerateRoute: RouteGenerator.generateRoute,
                  home: const HomeScreen(),
                ),
              ),
            ),
          );
        });
  }
}
