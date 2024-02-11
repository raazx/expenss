import 'package:flutter/material.dart';
import 'package:expenss/expenses.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kColorSchemeLight =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 202, 76, 196));
final kColorSchemeDark = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((value) => runApp(const MyApp()));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      title: 'Expenses Traker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorSchemeLight,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSchemeLight.onPrimaryContainer,
          foregroundColor: kColorSchemeLight.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorSchemeLight.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchemeLight.primaryContainer),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kColorSchemeDark,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSchemeDark.onPrimaryContainer,
          foregroundColor: kColorSchemeDark.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorSchemeDark.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchemeDark.primaryContainer),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorSchemeDark.onSecondaryContainer,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeDark.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      home: const Expenses(),
    );
  }
}
