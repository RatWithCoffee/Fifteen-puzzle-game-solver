import 'package:flutter/material.dart';
import 'package:puzzle/pages/home_page.dart';

void main() => runApp(const PuzzleApp());

class PuzzleApp extends StatelessWidget {
  const PuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Пятнашки',
        theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            surface: Colors.teal,
            onSurface: Colors.black,
            primary: Colors.teal,
            onPrimary: Colors.black,
            secondary: Colors.teal,
            onSecondary: Colors.black,
            background: Colors.white12,
            onBackground: Colors.black,
            error: Colors.teal,
            onError: Colors.black,

          ),
        ),
        home: const HomePage());
  }
}
