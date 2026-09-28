import 'package:url_launcher/url_launcher.dart';
import '../data/station_coordinates.dart';

class MapService {
  Future<void> openStationOnMap(String station) async {
    final coordinate = stationCoordinates[station];

    if (coordinate == null) {
      throw Exception(
        'Location not available for $station',
      );
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=${coordinate.latitude},${coordinate.longitude}',
    );

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception(
        'Could not open Google Maps.',
      );
    }
  }
}
