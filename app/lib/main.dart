import 'package:flutter/material.dart';
import 'package:kolibri/ui/home.dart';

const color01 = Color(0xFFDE00FF);

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: color01),
      brightness: Brightness.dark,
    ),
    title: "Kolibri App",
    home: const Home(),
  ));
}
