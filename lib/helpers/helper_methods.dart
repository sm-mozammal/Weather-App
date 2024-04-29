import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import '../common_widgets/custom_button.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';
import '/helpers/di.dart';
import '/helpers/toast.dart';
import 'locations_helper.dart';

Future<void> setInitValue() async {
  appData.writeIfNull(kKeyCountryCode, 'Bangladesh');
  appData.writeIfNull(kKeySelectedLocation, false);
  appData.writeIfNull(kKeySwitchTemp, false);

  await appData.writeIfNull(kKeySelectedLat, 22.818285677915657);
  await appData.writeIfNull(kKeySelectedLng, 89.5535583794117);

  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    appData.writeIfNull(
        kKeyDeviceID, iosDeviceInfo.identifierForVendor); // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo =
        await deviceInfo.androidInfo; // unique ID on Android
    appData.writeIfNull(kKeyDeviceID, androidDeviceInfo.id);
  }
  await Future.delayed(const Duration(seconds: 2));
}

setLocationLatLong(LatLng latLng, {bool? selectedLocation = false}) async {
  await appData.write(kKeySelectedLat, latLng.latitude);
  await appData.write(kKeySelectedLng, latLng.longitude);
  await appData.write(kKeySelectedLocation, selectedLocation);
}

Future<void> getLocation() async {
  try {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location service is disabled
      ToastUtil.showLongToast("Location service is disabled");
      return;
    }
    final position = await determinePosition();
    List<Placemark> countryName =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (countryName.isNotEmpty) {
      final country = countryName.first.country!;
      appData.write(kKeyCountryCode, country);
      appData.write(kKeySelectedLat, position.latitude.toString());
      appData.write(kKeySelectedLng, position.longitude.toString());
      log(country);
    }
  } catch (e) {
    log(e.toString());
    ToastUtil.showLongToast(e.toString());
  }
}

Future<void> initInternetChecker() async {
  InternetConnectionChecker.createInstance(
          checkTimeout: const Duration(seconds: 1),
          checkInterval: const Duration(seconds: 2))
      .onStatusChange
      .listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        ToastUtil.showShortToast('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        ToastUtil.showNoInternetToast();
        break;
    }
  });
}

void showMaterialDialog(
  BuildContext context,
) {
  showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Do you want to exit the app?",
              textAlign: TextAlign.center,
              style: TextFontStyle.headline14StyleInter,
            ),
            actions: <Widget>[
              customeButton(
                  name: "No",
                  onCallBack: () {
                    Navigator.of(context).pop(false);
                  },
                  height: 30.sp,
                  minWidth: .3.sw,
                  borderRadius: 30.r,
                  color: AppColors.cF0F0F0,
                  textStyle: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      color: AppColors.allPrimaryColor,
                      fontWeight: FontWeight.w700),
                  context: context),
              customeButton(
                  name: "Yes",
                  onCallBack: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  height: 30.sp,
                  minWidth: .3.sw,
                  borderRadius: 30.r,
                  color: AppColors.allPrimaryColor,
                  textStyle: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  context: context),
            ],
          ));
}

void rotation() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

String formatedHour(String date) {
  // String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(date);

  // Format only the time part
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  // String formattedTime = DateFormat('HH:mm:').format(date);
  return formattedTime;
}

String formatedDate(String date) {
  // String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(date);

  // Format only the time part
  String formattedTime = DateFormat('MM-dd').format(dateTime);
  return formattedTime;
}

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  DateTime now = DateTime.now();

  if (isSameDay(dateTime, now)) {
    return 'Today';
  } else if (isNextDay(dateTime, now)) {
    return 'Tomorrow';
  } else {
    return DateFormat('EEEE').format(dateTime); // Returns the full weekday name
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

bool isNextDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day - date2.day == 1;
}
