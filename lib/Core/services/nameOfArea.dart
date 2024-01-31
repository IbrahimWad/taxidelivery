import 'package:geocoding/geocoding.dart';

class AreaServices {
  Future<String> AreaServicesName(double latitude, double longitude) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    final place1 = placemarks[0];
    final currentAddress = "${place1.country} ${place1.administrativeArea}";
    return currentAddress;
  }
}
