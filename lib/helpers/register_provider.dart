import 'package:provider/provider.dart';

import '../provider/address.dart';
import '../provider/forecast_provider.dart';

var providers = [
  ChangeNotifierProvider<AddressProvider>(
    create: ((context) => AddressProvider()),
  ),
  ChangeNotifierProvider<ForecastProvider>(
    create: ((context) => ForecastProvider()),
  ),
];
