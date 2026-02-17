import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.lowest,
    distanceFilter: 100,
  );

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      print("erooooorrrrrrrrrrrrr");
      print(e);
    }
  }
}
