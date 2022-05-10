import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kolibri/main.dart';

class Drone extends StatefulWidget {
  const Drone({Key? key}) : super(key: key);

  @override
  DroneState createState() => DroneState();
}

class DroneState extends State<Drone> {
  @override
  Widget build(BuildContext context) {
    // Setting status and navigation bar colors.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: color01,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(pagesPadding),
        child: ListView(
          children: const [Text("Hello, Drone!")],
        ),
      ),
    );
  }
}
