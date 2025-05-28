import 'package:flutter/material.dart';

import 'widgets/expenses.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
ColorScheme kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125), brightness: Brightness.dark);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(foregroundColor: kColorScheme.primaryContainer, backgroundColor: kColorScheme.onPrimaryContainer),
        cardTheme: CardTheme(color: kColorScheme.secondaryContainer, margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: kColorScheme.primaryContainer)),
        textTheme: TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.bold, color: kColorScheme.onSecondaryContainer, fontSize: 16), titleMedium: TextStyle(color: kColorScheme.onSecondaryContainer, fontSize: 14)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        // appBarTheme: AppBarTheme(foregroundColor: kDarkColorScheme.primaryContainer, backgroundColor: kDarkColorScheme.onPrimaryContainer),
        cardTheme: CardTheme(color: kDarkColorScheme.secondaryContainer, margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(foregroundColor: kDarkColorScheme.onPrimaryContainer, backgroundColor: kDarkColorScheme.primaryContainer)),
        textTheme: TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.bold, color: kDarkColorScheme.onSecondaryContainer, fontSize: 16), titleMedium: TextStyle(color: kDarkColorScheme.onSecondaryContainer, fontSize: 14)),
      ),
      home: const Scaffold(body: SafeArea(child: Expenses())),
    );
  }
}
