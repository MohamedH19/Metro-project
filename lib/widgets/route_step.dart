import 'package:flutter/material.dart';

class RouteStep extends StatelessWidget {
  final String station;
  final String? line;

  const RouteStep({
    super.key,
    required this.station,
    required this.line,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.train),
      title: Text(station),
      subtitle: line != null ? Text(line!) : null,
    );
  }
}