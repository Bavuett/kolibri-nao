import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kolibri/main.dart';

class Robot extends StatefulWidget {
  const Robot({Key? key}) : super(key: key);

  @override
  RobotState createState() => RobotState();
}

class RobotState extends State<Robot> {
  @override
  Widget build(BuildContext context) {
    // Setting status and navigation bar colors.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: color01,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    // Getting the Screen Size.
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(pagesPadding),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Robot",
                style: TextStyle(
                  fontFamily: "CorporateS",
                  fontSize: 32,
                ),
              ),
              Text("Control the Robot with this list of commands."),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Introductions",
                  style: TextStyle(fontFamily: "CorporateS", fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: null,
                      child: Text("Tap me!"),
                    ),
                    Container(
                      width: screenSize.width * 0.05,
                    ),
                    ElevatedButton(
                      onPressed: null,
                      child: Text("Tap me!"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}