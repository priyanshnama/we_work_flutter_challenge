import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:we_work_flutter_challenge/data/user_address.dart';

class LocationService {
  Future<Position> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the user's current location
    return await Geolocator.getCurrentPosition();
  }

  Future<UserAddress> getAddressFromLatLng() async {
    Position position = await _getUserLocation();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];

      String mainAddress = "${place.name}, ${place.thoroughfare}";
      String secondaryAddress =
          "${place.thoroughfare}, ${place.subLocality}, ${place.locality}";
      return UserAddress(
          mainAddress: mainAddress, secondaryAddress: secondaryAddress);
    }
    return UserAddress(mainAddress: "error", secondaryAddress: "error");
  }
}
