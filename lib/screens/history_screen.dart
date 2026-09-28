import 'package:flutter/material.dart';
import '../services/history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {
  final HistoryService historyService =
      HistoryService();

  List<Map<String, dynamic>> history = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadHistory();
  }

  Future<void> loadHistory() async {
    final data =
        await historyService.getHistory();

    if (!mounted) {
      return;
    }

    setState(() {
      history = data;
      isLoading = false;
    });
  }

  Future<void> deleteItem(int index) async {
    await historyService.deleteHistory(index);

    await loadHistory();
  }

  Future<void> clearAll() async {
    await historyService.clearHistory();

    await loadHistory();
  }

  Future<void> confirmClearAll() async {
    if (history.isEmpty) {
      return;
    }

    final shouldClear =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Clear History',
          ),
          content: const Text(
            'Are you sure you want to delete all journeys?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Clear',
              ),
            ),
          ],
        );
      },
    );

    if (shouldClear == true) {
      await clearAll();
    }
  }

  Future<void> confirmDeleteItem(
    int index,
  ) async {
    final item = history[index];

    final shouldDelete =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Journey',
          ),
          content: Text(
            'Delete ${item['start']} → ${item['destination']}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await deleteItem(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
        ),
        actions: [
          if (history.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.delete_sweep,
              ),
              tooltip: 'Clear History',
              onPressed: confirmClearAll,
            ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : history.isEmpty
              ? const Center(
                  child: Text(
                    'No journeys yet.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.all(15),
                  itemCount: history.length,
                  itemBuilder:
                      (context, index) {
                    final item =
                        history[index];

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: ListTile(
                        leading:
                            const CircleAvatar(
                          child: Icon(
                            Icons.train,
                          ),
                        ),
                        title: Text(
                          '${item['start']} → '
                          '${item['destination']}',
                        ),
                        subtitle: Text(
                          '${item['stations']} stations • '
                          '${item['time']} min • '
                          '${item['ticket']} EGP',
                        ),
                        trailing:
                            IconButton(
                          icon: const Icon(
                            Icons.delete,
                          ),
                          tooltip:
                              'Delete Journey',
                          onPressed: () =>
                              confirmDeleteItem(
                            index,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
