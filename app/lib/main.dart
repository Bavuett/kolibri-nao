import 'package:flutter/material.dart';
import 'package:kolibri/ui/home.dart';

const color01 = Color(0xFFDE00FF);

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: color01),
    title: "Kolibri App",
    home: const Home(),
  ));
}
