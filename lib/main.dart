import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MetroApp(),
  );
}

class MetroApp extends StatelessWidget {
  const MetroApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Cairo Metro',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme:
            ColorScheme.fromSeed(
          seedColor:
              Colors.red,
        ),

        inputDecorationTheme:
            const InputDecorationTheme(
          border:
              OutlineInputBorder(),
        ),
      ),

      home:
          const HomeScreen(),
    );
  }
}