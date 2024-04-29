import 'package:flutter/widgets.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/helpers/di.dart';

final class ChangeUnitPorvider extends ChangeNotifier {
  bool _select = appData.read(kKeySwitchTemp);

  bool get select => _select;

  void changeUnit(bool value) {
    _select = value;
    appData.write(kKeySwitchTemp, value);
    notifyListeners();
  }

  // void setList(List<Hour> list) {
  //   _hour = list;
  //   notifyListeners();
  // }
}
