import 'dart:collection';

import 'models/line.dart';

class Metro {
  List<Line> lines;

  Metro({required this.lines});

  // =================================================
  // Find Route
  // =================================================

  void findRoute(String startStation, String arrivalStation) {
    String start = findStation(startStation);
    String arrival = findStation(arrivalStation);

    // =========================
    // Check Start
    // =========================

    if (start == '') {
      print('Start station not found.');
      return;
    }

    // =========================
    // Check Arrival
    // =========================

    if (arrival == '') {
      print('Arrival station not found.');
      return;
    }

    // =========================
    // BFS
    // =========================

    Queue<String> queue = Queue();

    Set<String> visited = {};

    Map<String, String?> previous = {};

    queue.add(start);

    visited.add(start);

    previous[start] = null;

    while (queue.isNotEmpty) {
      String current = queue.removeFirst();

      if (current.toLowerCase() == arrival.toLowerCase()) {
        break;
      }

      List<String> neighbors = getNeighbors(current);

      for (String station in neighbors) {
        if (!visited.contains(station)) {
          visited.add(station);

          previous[station] = current;

          queue.add(station);
        }
      }
    }

    // =========================
    // No Route
    // =========================

    if (!visited.contains(arrival)) {
      print('No route found.');
      return;
    }

    // =========================
    // Build Route
    // =========================

    List<String> route = [];

    String? current = arrival;

    while (current != null) {
      route.add(current);

      current = previous[current];
    }

    route = route.reversed.toList();

    // =========================
    // Find Lines
    // =========================

    List<String?> routeLines = [];

    for (int i = 0; i < route.length - 1; i++) {
      String? line = findLineBetween(route[i], route[i + 1]);

      routeLines.add(line);
    }

    // =========================
    // Number Of Stations
    // =========================

    int numberOfStations = route.length - 1;

    // =========================
    // Time
    // =========================

    Time time = Time(sumStation: numberOfStations);

    // =========================
    // Ticket
    // =========================

    Ticket ticket = Ticket(sumStation: numberOfStations);

    // =========================
    // Output
    // =========================

    print('');

    print('========== Metro Information ==========');

    print('From: $start');
    print('To: $arrival');

    // =========================
    // Route
    // =========================

    print('');

    print('========== Route ==========');

    print(route.join(' → '));

    print('===========================');

    print('');

    // =========================
    // Lines
    // =========================

    String? currentLine;

    for (int i = 0; i < routeLines.length; i++) {
      String? line = routeLines[i];

      if (line == null) {
        continue;
      }

      // =========================
      // First Line
      // =========================

      if (currentLine == null) {
        currentLine = line;

        print('----------------------------------------');

        print('Line: $currentLine');

        String direction = getDirection(route[i], route[i + 1], currentLine);

        print('Direction: $direction');

        continue;
      }

      // =========================
      // Interchange
      // =========================

      if (line != currentLine) {
        String interchangeStation = route[i];

        print('');

        print('========== Interchange ==========');

        print('Station: $interchangeStation');

        print('From: $currentLine');

        print('To: $line');

        print('=================================');

        print('');

        // =========================
        // New Line
        // =========================

        currentLine = line;

        print('Line: $currentLine');

        String direction = getDirection(route[i], route[i + 1], currentLine);

        print('Direction: $direction');
      }
    }

    // =========================
    // Time & Ticket
    // =========================

    print('');

    print('Number of stations: $numberOfStations');

    print('Time: ${time.totalTime} minutes');

    print('Ticket Price: ${ticket.price} EGP');

    print('========================================');
  }

  // =================================================
  // Get Neighbors
  // =================================================

  List<String> getNeighbors(String station) {
    List<String> neighbors = [];

    for (Line line in lines) {
      for (int i = 0; i < line.stations.length; i++) {
        if (line.stations[i].toLowerCase() == station.toLowerCase()) {
          // Previous station
          if (i > 0) {
            neighbors.add(line.stations[i - 1]);
          }

          // Next station
          if (i < line.stations.length - 1) {
            neighbors.add(line.stations[i + 1]);
          }
        }
      }
    }

    return neighbors;
  }

  // =================================================
  // Find Line Between Two Stations
  // =================================================

  String? findLineBetween(String station1, String station2) {
    for (Line line in lines) {
      for (int i = 0; i < line.stations.length - 1; i++) {
        String current = line.stations[i];

        String next = line.stations[i + 1];

        // Forward
        if (current.toLowerCase() == station1.toLowerCase() &&
            next.toLowerCase() == station2.toLowerCase()) {
          return line.name;
        }

        // Backward
        if (current.toLowerCase() == station2.toLowerCase() &&
            next.toLowerCase() == station1.toLowerCase()) {
          return line.name;
        }
      }
    }

    return null;
  }

  // =================================================
  // Get Direction
  // =================================================

  String getDirection(
    String currentStation,
    String nextStation,
    String lineName,
  ) {
    for (Line line in lines) {
      if (line.name == lineName) {
        int currentIndex = line.stations.indexWhere(
          (station) => station.toLowerCase() == currentStation.toLowerCase(),
        );

        int nextIndex = line.stations.indexWhere(
          (station) => station.toLowerCase() == nextStation.toLowerCase(),
        );

        if (currentIndex == -1 || nextIndex == -1) {
          return '';
        }

        if (nextIndex > currentIndex) {
          return line.stations.last;
        }

        return line.stations.first;
      }
    }

    return '';
  }

  // =================================================
  // Find Station
  // =================================================

  String findStation(String station) {
    for (Line line in lines) {
      for (String currentStation in line.stations) {
        if (currentStation.toLowerCase() == station.toLowerCase()) {
          return currentStation;
        }
      }
    }

    return '';
  }
}

// ===================================================
// Time
// ===================================================

class Time {
  int timePerStation = 2;

  late int totalTime;

  Time({required int sumStation}) {
    totalTime = timePerStation * sumStation;
  }
}

// ===================================================
// Ticket
// ===================================================

class Ticket {
  late int price;

  Ticket({required int sumStation}) {
    if (sumStation <= 9) {
      price = 10;
    } else if (sumStation <= 16) {
      price = 12;
    } else if (sumStation <= 23) {
      price = 15;
    } else {
      price = 20;
    }
  }
}