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
      body: ListView(
        padding: const EdgeInsets.all(pagesPadding),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Drone",
                style: TextStyle(
                  fontFamily: "CorporateS",
                  fontSize: 32,
                ),
              ),
              Text("Control the Drone with this list of commands."),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Introductions"),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        debugPrint("Pressed");
                      },
                      child: const Text("Tap me!"),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
