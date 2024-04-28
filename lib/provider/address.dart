import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/helper_methods.dart';

final class AddressProvider extends ChangeNotifier {
  String _address = "You are not logged in";

  String get name => _address;

  updateName(
      {required String address,
      required double lat,
      required double lng,
      bool? selectedLocation}) {
    _address = address;
    setLocationLatLong(LatLng(lat, lng), selectedLocation: selectedLocation);
    notifyListeners();
  }
}
