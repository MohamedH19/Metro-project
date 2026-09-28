
import 'package:flutter/material.dart';

import '../data/metro_data.dart';
import '../models/line.dart';
import '../models/metro_route.dart';
import '../services/history_service.dart';
import '../services/location_service.dart';
import '../services/map_service.dart';
import '../services/metro_service.dart';
import '../services/nearest_station_service.dart';
import '../services/place_service.dart';
import '../widgets/station_dropdown.dart';
import 'history_screen.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  late final MetroService metroService;

  final locationService = LocationService();

  final nearestStationService =
      NearestStationService();

  final placeService = PlaceService();

  final mapService = MapService();

  final historyService = HistoryService();

  String? startStation;

  String? destinationStation;

  final placeController =
      TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    metroService = MetroService(
      lines: [
        l1,
        l2,
        l3,
        rodElFarag,
        cairoUniversityBranch,
      ],
    );
  }

  List<String> get allStations {
    final Set<String> stations = {};

    for (final Line line
        in metroService.lines) {
      stations.addAll(line.stations);
    }

    return stations.toList();
  }

  Future<void> findNearestStart() async {
    setState(() {
      isLoading = true;
    });

    try {
      final position =
          await locationService
              .getCurrentLocation();

      final nearest =
          nearestStationService
              .findNearestStation(
        position,
      );

      if (nearest != null) {
        setState(() {
          startStation = nearest;
        });

        showMessage(
          'Nearest station: $nearest',
        );
      }
    } catch (e) {
      showMessage(
        e.toString(),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> findNearestDestination() async {
    if (placeController.text
        .trim()
        .isEmpty) {
      showMessage(
        'Enter a destination place first.',
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final location =
          await placeService
              .getPlaceLocation(
        placeController.text.trim(),
      );

      if (location == null) {
        showMessage(
          'Could not find this place.',
        );

        return;
      }

      final nearest =
          nearestStationService
              .findNearestFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (nearest != null) {
        setState(() {
          destinationStation = nearest;
        });

        showMessage(
          'Nearest station: $nearest',
        );
      } else {
        showMessage(
          'Could not find a nearby metro station.',
        );
      }
    } catch (e) {
      showMessage(
        'Could not find destination.',
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> showStationOnMap(
    String station,
  ) async {
    try {
      await mapService
          .openStationOnMap(station);
    } catch (e) {
      showMessage(
        'Could not open map.',
      );
    }
  }

  Future<void> calculateRoute() async {
    if (startStation == null ||
        destinationStation == null) {
      showMessage(
        'Please select start and destination stations.',
      );

      return;
    }

    if (startStation ==
        destinationStation) {
      showMessage(
        'Start and destination must be different.',
      );

      return;
    }

    final MetroRoute? route =
        metroService.calculateRoute(
      startStation!,
      destinationStation!,
    );

    if (route == null) {
      showMessage(
        'No route found.',
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await historyService.addHistory(
        start: route.startStation,
        destination: route.arrivalStation,
        stations: route.numberOfStations,
        time: route.time,
        ticket: route.ticketPrice,
      );
    } catch (e) {
      showMessage(
        'Could not save journey to history.',
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }

    if (!mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          route: route,
        ),
      ),
    );
  }

  void showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    placeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cairo Metro',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history,
            ),
            tooltip: 'History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,

            children: [
              const Text(
                'Plan Your Journey',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Choose your metro stations',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              StationDropdown(
                label:
                    'Starting Station',
                value: startStation,
                stations: allStations,
                onChanged: (value) {
                  setState(() {
                    startStation = value;
                  });
                },
              ),

              if (startStation != null) ...[
                const SizedBox(height: 8),

                OutlinedButton.icon(
                  onPressed: () {
                    showStationOnMap(
                      startStation!,
                    );
                  },
                  icon: const Icon(
                    Icons.map,
                  ),
                  label: const Text(
                    'Show Starting Station on Map',
                  ),
                ),
              ],

              const SizedBox(height: 15),

              StationDropdown(
                label:
                    'Destination Station',
                value:
                    destinationStation,
                stations: allStations,
                onChanged: (value) {
                  setState(() {
                    destinationStation =
                        value;
                  });
                },
              ),

              if (destinationStation !=
                  null) ...[
                const SizedBox(height: 8),

                OutlinedButton.icon(
                  onPressed: () {
                    showStationOnMap(
                      destinationStation!,
                    );
                  },
                  icon: const Icon(
                    Icons.map,
                  ),
                  label: const Text(
                    'Show Destination on Map',
                  ),
                ),
              ],

              const SizedBox(height: 20),

              OutlinedButton.icon(
                onPressed: isLoading
                    ? null
                    : findNearestStart,
                icon: const Icon(
                  Icons.my_location,
                ),
                label: const Text(
                  'Use My Location',
                ),
              ),

              const SizedBox(height: 25),

              const Divider(),

              const SizedBox(height: 15),

              const Text(
                'Going to a place?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller:
                    placeController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Destination place',
                  hintText:
                      'Example: Abbas El Akkad',
                  prefixIcon: Icon(
                    Icons.place,
                  ),
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              OutlinedButton(
                onPressed: isLoading
                    ? null
                    : findNearestDestination,
                child: const Text(
                  'Find Nearest Station',
                ),
              ),

              const SizedBox(height: 30),

              FilledButton(
                onPressed: isLoading
                    ? null
                    : calculateRoute,
                style:
                    FilledButton.styleFrom(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'CALCULATE ROUTE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              if (isLoading) ...[
                const SizedBox(height: 20),

                const Center(
                  child:
                      CircularProgressIndicator(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
