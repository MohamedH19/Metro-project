import 'package:geolocator/geolocator.dart';

import '../data/station_coordinates.dart';

class NearestStationService {
String? findNearestStation(Position position) {
return findNearestFromCoordinates(
position.latitude,
position.longitude,
);
}

String? findNearestFromCoordinates(
double latitude,
double longitude,
) {
String? nearestStation;
double smallestDistance = double.infinity;

stationCoordinates.forEach(
  (station, coordinate) {
    final distance = Geolocator.distanceBetween(
      latitude,
      longitude,
      coordinate.latitude,
      coordinate.longitude,
    );

    if (distance < smallestDistance) {
      smallestDistance = distance;
      nearestStation = station;
    }
  },
);

return nearestStation;
}
}