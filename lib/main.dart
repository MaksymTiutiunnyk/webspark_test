import 'package:flutter/material.dart';
import 'package:webspark_test/presentation/screens/home.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webspark test',
      theme: ThemeData(
        colorScheme: kColorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.inversePrimary,
          foregroundColor: kColorScheme.onInverseSurface,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
