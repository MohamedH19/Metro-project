import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String key = 'metro_history';

  final SharedPreferencesAsync prefs =
      SharedPreferencesAsync();

  Future<List<Map<String, dynamic>>> getHistory() async {
    final data = await prefs.getStringList(key);

    if (data == null || data.isEmpty) {
      return [];
    }

    return data
        .map(
          (item) =>
              jsonDecode(item) as Map<String, dynamic>,
        )
        .toList();
  }

  Future<void> addHistory({
    required String start,
    required String destination,
    required int stations,
    required int time,
    required int ticket,
  }) async {
    final history = await getHistory();

    history.insert(
      0,
      {
        'start': start,
        'destination': destination,
        'stations': stations,
        'time': time,
        'ticket': ticket,
        'date': DateTime.now().toIso8601String(),
      },
    );

    final encoded = history
        .map(
          (item) => jsonEncode(item),
        )
        .toList();

    await prefs.setStringList(
      key,
      encoded,
    );
  }

  Future<void> deleteHistory(int index) async {
    final history = await getHistory();

    if (index < 0 || index >= history.length) {
      return;
    }

    history.removeAt(index);

    final encoded = history
        .map(
          (item) => jsonEncode(item),
        )
        .toList();

    await prefs.setStringList(
      key,
      encoded,
    );
  }

  Future<void> clearHistory() async {
    await prefs.remove(key);
  }
}
