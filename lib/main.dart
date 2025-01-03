import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webspark_test/presentation/screens/home.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const WebsparkTest()));
}

class WebsparkTest extends StatelessWidget {
  const WebsparkTest({super.key});

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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: kColorScheme.primary,
                width: 2,
              ),
            ),
            backgroundColor: kColorScheme.inversePrimary,
            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
