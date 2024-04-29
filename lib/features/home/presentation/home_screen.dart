// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/features/home/bloc/bloc.dart';
import 'package:weather_app/features/home/bloc/state.dart';
import 'package:weather_app/features/home/presentation/widgets/custom_container.dart';
import 'package:weather_app/helpers/all_routes.dart';
import 'package:weather_app/helpers/ui_helpers.dart';
import 'package:weather_app/provider/change_unite_provider.dart';
import 'package:weather_app/provider/forecast_provider.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/di.dart';
import '../../../helpers/helper_methods.dart';
import '../bloc/event.dart';
import 'widgets/action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool swithValue = appData.read(kKeySwitchTemp);

  @override
  void initState() {
    // Call getLocation in initState to get weather data initially
    getLocation().then((value) => context.read<WeatherBloc>().add(
          InitialCurrentWeatherEvent(
              lat: appData.read(kKeySelectedLat),
              lon: appData.read(kKeySelectedLng)),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherInitialState) {
            return const Center(
              child: Text('Finding Your Location....'),
            );
          } else if (state is CurrentDataFetchState) {
            return Container(
              width: double.infinity,
              // Container Decoration with color gradient
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.71, -0.71),
                  end: Alignment(-0.71, 0.71),
                  colors: [
                    AppColors.c97ABFF,
                    AppColors.c123597,
                  ],
                ),
              ),
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display Location
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        state.currentWeather.location!.name ?? '',
                        style: TextFontStyle.headline32StyleInter,
                      ),
                      UIHelper.horizontalSpaceExtraLarge,
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.setting);
                        },
                        child: Icon(
                          Icons.settings,
                          color: AppColors.cFEFFFE,
                          size: 30.sp,
                        ),
                      ),
                      UIHelper.horizontalSpaceMedium,
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,

                  // Detect Current Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.icons.location),
                      Text('Current Location',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline12StyleInter)
                    ],
                  ),

                  // Display Today Weather Condition Icon & Today Temparature
                  _weatherImage(state),

                  // Display Today Weather condition
                  Text(
                    '${state.currentWeather.current!.condition!.text ?? ''}  -  H:${state.currentWeather.current!.humidity ?? ''}\u00B0  L:4\u00B0',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline18StyleInter,
                  ),

                  UIHelper.verticalSpaceMediumLarge,

                  // ForecastWeather for Next Dates
                  _forecastWeather(state),
                  UIHelper.verticalSpaceMedium,

                  // Display astro Information (Sunset and Sunrise Time)
                  _astroSection(state),
                  UIHelper.verticalSpaceMedium,

                  // Display UV Iindex Value
                  _uvIndexSection(state)
                ],
              )),
            );
          } else {
            final massage = state as DataFetchingErrorState;
            return Text(massage.massage);
          }
        }),
      ),
    );
  }

  CustomContainer _uvIndexSection(CurrentDataFetchState state) {
    return CustomContainer(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          Assets.icons.sun,
          height: 56.h,
          width: 56.sp,
        ),
        Column(
          children: [
            Text(
              'UV Index',
              style: TextFontStyle.headline16StyleInter,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: state.currentWeather.current!.uv.toString(),
                    style: TextFontStyle.headline24StyleInter,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _astroSection(CurrentDataFetchState state) {
    return CustomContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Condition Image
              SvgPicture.asset(
                Assets.icons.sunFog,
                height: 56.h,
                width: 56.sp,
              ),

              // Display Sun Set Information
              _sunsetInfo(state),

              // Display Sunrise Information
              _sunriseInfo(state),
            ],
          ),
        ],
      ),
    );
  }

  Column _sunsetInfo(CurrentDataFetchState state) {
    return Column(
      children: [
        Text(
          'Sunset',
          style: TextFontStyle.headline16StyleInter,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: state
                    .forecastWeather.forecast!.forecastday!.first.astro!.sunset,
                style: TextFontStyle.headline24StyleInter,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _sunriseInfo(CurrentDataFetchState state) {
    return Column(
      children: [
        Text(
          'Sunrise',
          style: TextFontStyle.headline16StyleInter,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: state.forecastWeather.forecast!.forecastday!.first.astro!
                    .sunrise,
                style: TextFontStyle.headline24StyleInter,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Consumer<ForecastProvider> _forecastWeather(CurrentDataFetchState state) {
    return Consumer<ForecastProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          // Select Date to Display Spacific Date ForecastWeather
          _forecastButton(state, provider),
          UIHelper.verticalSpaceMedium,

          // Display Spacific ForecastWeather Data
          _hourlyForecast(state, provider)
        ],
      );
    });
  }

  SizedBox _hourlyForecast(
      CurrentDataFetchState state, ForecastProvider provider) {
    return SizedBox(
      height: 180.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.forecastWeather.forecast!
              .forecastday![provider.index].hour!.length,
          itemBuilder: (context, index) {
            log("provider index:" + provider.index.toString());
            final data = state
                .forecastWeather.forecast!.forecastday![provider.index].hour!;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                width: 80.w,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.26, -0.97),
                    end: Alignment(-0.26, 0.97),
                    colors: [
                      AppColors.c91A3DE,
                      AppColors.c546FC5,
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.transparent,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Column(
                  children: [
                    // Display Time
                    Text(
                      formatedHour(data[index].time!),
                      textAlign: TextAlign.center,
                      style: TextFontStyle.headline16StyleInter,
                    ),
                    UIHelper.verticalSpaceSmall,

                    // Display Weather Condition Icon
                    SizedBox(
                      height: 58.h,
                      width: 48.w,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: 'https:${data[index].condition!.icon}',
                        placeholder: (context, url) =>
                            SvgPicture.asset(Assets.icons.partlyCloudy),
                        errorWidget: (context, url, error) =>
                            SvgPicture.asset(Assets.icons.partlyCloudy),
                      ),
                    ),

                    // Display this temparature
                    Text(
                      '${data[index].tempC}\u00B0',
                      style: TextFontStyle.headline18StyleInter400,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  SizedBox _forecastButton(
      CurrentDataFetchState state, ForecastProvider provider) {
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        padding: EdgeInsets.all(5.h),
        scrollDirection: Axis.horizontal,
        itemCount: state.forecastWeather.forecast!.forecastday!.length,
        itemBuilder: (context, index) {
          final data = state.forecastWeather.forecast!.forecastday!;
          log(data.length.toString());
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),

            // Action Button For Display Selected Day Forecast Weather
            child: ActionButton(
              index: index,
              onTap: () {
                log('Action button clicked');
                provider.setList(data[index].hour!);
                provider.changeIndex(index);
                log(formatDateString(data[index].date.toString()));
              },
              buttonName: formatDateString(data[index].date.toString()),
            ),
          );
        },
      ),
    );
  }

  Row _weatherImage(CurrentDataFetchState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display Image
        SizedBox(
          // width: 135.w,
          // heigsht: 130.h,
          child: CachedNetworkImage(
            // width: 135.w,
            // height: 130.h,
            fit: BoxFit.fill,
            imageUrl:
                'https:${state.currentWeather.current!.condition!.icon ?? ''}',
            placeholder: (context, url) =>
                SvgPicture.asset(Assets.icons.partlyCloudy),
            errorWidget: (context, url, error) =>
                SvgPicture.asset(Assets.icons.partlyCloudy),
          ),
        ),

        // Display Today Temparater
        Consumer<ChangeUnitPorvider>(builder: (context, provider, child) {
          return Text(
              !provider.select
                  ? '${state.currentWeather.current!.tempC ?? ''}\u00B0'
                  : '${state.currentWeather.current!.tempF ?? ''}\u00B0',
              textAlign: TextAlign.right,
              style: TextFontStyle.headline70StyleInter);
        })
      ],
    );
  }
}
