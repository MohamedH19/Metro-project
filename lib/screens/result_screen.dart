import 'package:flutter/material.dart';

import '../models/metro_route.dart';
import '../widgets/info_card.dart';
import '../widgets/route_step.dart';

class ResultScreen extends StatelessWidget {
  final MetroRoute route;

  const ResultScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journey Details')),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Your Journey',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                '${route.startStation} → ${route.arrivalStation}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),

              const SizedBox(height: 25),

              InfoCard(
                title: 'Number of Stations',
                value: '${route.numberOfStations}',
                icon: Icons.train,
              ),

              const SizedBox(height: 12),

              InfoCard(
                title: 'Estimated Time',
                value: '${route.time} minutes',
                icon: Icons.access_time,
              ),

              const SizedBox(height: 12),

              InfoCard(
                title: 'Ticket Price',
                value: '${route.ticketPrice} EGP',
                icon: Icons.payments,
              ),

              const SizedBox(height: 12),

              InfoCard(
                title: 'Direction',
                value: getDirection(),
                icon: Icons.directions_subway,
              ),

              const SizedBox(height: 30),

              const Text(
                'Route',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: route.stations.length,

                  itemBuilder: (context, index) {
                    // Prevent index out of range if
                    // stations and lines have different lengths.
                    String? line;

                    if (index < route.lines.length) {
                      line = route.lines[index];
                    }

                    return RouteStep(
                      station: route.stations[index],
                      line: line,
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDirection() {
    // We need at least two stations.
    if (route.stations.length < 2) {
      return 'N/A';
    }

    final firstStation = route.stations[0];
    final secondStation = route.stations[1];

    // Make sure line index 0 exists.
    if (route.lines.isEmpty) {
      return '$firstStation → $secondStation';
    }

    final line = route.lines[0];

    if (line == null) {
      return '$firstStation → $secondStation';
    }

    return '$line: $firstStation → $secondStation';
  }
}
