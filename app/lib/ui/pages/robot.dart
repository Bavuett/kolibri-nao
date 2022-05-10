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
      statusBarColor: color01,
      systemNavigationBarColor: color01,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(pagesPadding),
        child: ListView(
          children: const [
            Text(
              "Hello, Robot!",
              style: TextStyle(fontFamily: "Halyard"),
            )
          ],
        ),
      ),
    );
  }
}
