import 'package:flutter/widgets.dart';
import '../features/home/model/forecast_weather.dart';

final class ForecastProvider extends ChangeNotifier {
  List<Hour> _hour = [];
  int _index = 0;

  List<Hour> get hour => _hour;
  int get index => _index;

  void changeIndex(int selectedIndex) {
    _index = selectedIndex;
    notifyListeners();
  }

  void setList(List<Hour> list) {
    _hour = list;
    notifyListeners();
  }
}
