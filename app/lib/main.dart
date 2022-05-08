import 'package:flutter/material.dart';
import 'package:kolibri/ui/home.dart';

// Color Scheme.
const color01 = Color(0xFFDE00FF);
const color02 = Color(0xFFF8A6CD);

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      // Theming the app bar.
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
      ),
      // Theming the rest of the app.
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: color01),
      scaffoldBackgroundColor: color02,
    ),
    // Setting the app title and telling Flutter what's the Home class.
    title: "Kolibri App",
    home: const Home(),
  ));
}
