import 'dart:collection';

import '../models/line.dart';
import '../models/metro_route.dart';

class MetroService {
  final List<Line> lines;

  MetroService({
    required this.lines,
  });

  String? findStation(String station) {
    for (final line in lines) {
      for (final currentStation in line.stations) {
        if (currentStation.toLowerCase() ==
            station.toLowerCase()) {
          return currentStation;
        }
      }
    }

    return null;
  }

  List<String> getNeighbors(String station) {
    final List<String> neighbors = [];

    for (final line in lines) {
      for (int i = 0; i < line.stations.length; i++) {
        if (line.stations[i].toLowerCase() ==
            station.toLowerCase()) {
          if (i > 0) {
            neighbors.add(line.stations[i - 1]);
          }

          if (i < line.stations.length - 1) {
            neighbors.add(line.stations[i + 1]);
          }
        }
      }
    }

    return neighbors;
  }

  String? findLineBetween(
    String station1,
    String station2,
  ) {
    for (final line in lines) {
      for (int i = 0; i < line.stations.length - 1; i++) {
        final current = line.stations[i];
        final next = line.stations[i + 1];

        if ((current.toLowerCase() ==
                station1.toLowerCase() &&
            next.toLowerCase() ==
                station2.toLowerCase()) ||
            (current.toLowerCase() ==
                station2.toLowerCase() &&
            next.toLowerCase() ==
                station1.toLowerCase())) {
          return line.name;
        }
      }
    }

    return null;
  }

  String getDirection(
    String currentStation,
    String nextStation,
    String lineName,
  ) {
    for (final line in lines) {
      if (line.name != lineName) {
        continue;
      }

      final currentIndex = line.stations.indexWhere(
        (station) =>
            station.toLowerCase() ==
            currentStation.toLowerCase(),
      );

      final nextIndex = line.stations.indexWhere(
        (station) =>
            station.toLowerCase() ==
            nextStation.toLowerCase(),
      );

      if (currentIndex == -1 || nextIndex == -1) {
        return '';
      }

      if (nextIndex > currentIndex) {
        return line.stations.last;
      }

      return line.stations.first;
    }

    return '';
  }

  MetroRoute? calculateRoute(
    String startStation,
    String arrivalStation,
  ) {
    final start = findStation(startStation);
    final arrival = findStation(arrivalStation);

    if (start == null || arrival == null) {
      return null;
    }

    final Queue<String> queue = Queue<String>();

    final Set<String> visited = {};

    final Map<String, String?> previous = {};

    queue.add(start);

    visited.add(start);

    previous[start] = null;

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      if (current.toLowerCase() ==
          arrival.toLowerCase()) {
        break;
      }

      final neighbors = getNeighbors(current);

      for (final station in neighbors) {
        if (!visited.contains(station)) {
          visited.add(station);

          previous[station] = current;

          queue.add(station);
        }
      }
    }

    if (!visited.contains(arrival)) {
      return null;
    }

    final List<String> route = [];

    String? current = arrival;

    while (current != null) {
      route.add(current);
      current = previous[current];
    }

    final finalRoute = route.reversed.toList();

    final List<String?> routeLines = [];

    for (int i = 0;
        i < finalRoute.length - 1;
        i++) {
      routeLines.add(
        findLineBetween(
          finalRoute[i],
          finalRoute[i + 1],
        ),
      );
    }

    final numberOfStations =
        finalRoute.length - 1;

    final time =
        numberOfStations * 2;

    final ticketPrice =
        calculateTicketPrice(numberOfStations);

    return MetroRoute(
      startStation: start,
      arrivalStation: arrival,
      stations: finalRoute,
      lines: routeLines,
      numberOfStations: numberOfStations,
      time: time,
      ticketPrice: ticketPrice,
    );
  }

  int calculateTicketPrice(int stations) {
    if (stations <= 9) {
      return 10;
    }

    if (stations <= 16) {
      return 12;
    }

    if (stations <= 23) {
      return 15;
    }

    return 20;
  }
}