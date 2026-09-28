class MetroRoute {
  final String startStation;
  final String arrivalStation;

  final List<String> stations;
  final List<String?> lines;

  final int numberOfStations;
  final int time;
  final int ticketPrice;

  const MetroRoute({
    required this.startStation,
    required this.arrivalStation,
    required this.stations,
    required this.lines,
    required this.numberOfStations,
    required this.time,
    required this.ticketPrice,
  });
}