import 'package:geolocator/geolocator.dart';
import '../data/station_coordinates.dart';


class LocationService {
  Future<Position> getCurrentLocation() async {
    final serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        'Location service is disabled.',
      );
    }

    var permission =
        await Geolocator.checkPermission();

    if (permission ==
        LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    if (permission ==
            LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {
      throw Exception(
        'Location permission was denied.',
      );
    }

    return Geolocator.getCurrentPosition();
  }
}