import 'package:flutter/material.dart';

class StationDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> stations;
  final ValueChanged<String?> onChanged;

  const StationDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.stations,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: stations.map((station) {
        return DropdownMenuItem<String>(
          value: station,
          child: Text(station),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}