import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class PlaceService {
  Future<LatLng?> getPlaceLocation(String place) async {
    try {
      final uri = Uri.parse(
        'https://nominatim.openstreetmap.org/search'
        '?q=${Uri.encodeComponent('$place, Cairo, Egypt')}'
        '&format=json'
        '&limit=1',
      );

      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'CairoMetroApp/1.0',
        },
      );

      if (response.statusCode != 200) {
        return null;
      }

      final data = jsonDecode(response.body);

      if (data is! List || data.isEmpty) {
        return null;
      }

      final result = data.first;

      final latitude = double.tryParse(
        result['lat'].toString(),
      );

      final longitude = double.tryParse(
        result['lon'].toString(),
      );

      if (latitude == null || longitude == null) {
        return null;
      }

      return LatLng(latitude, longitude);
    } catch (_) {
      return null;
    }
  }
}