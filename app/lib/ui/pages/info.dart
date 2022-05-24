import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kolibri/main.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  InfoState createState() => InfoState();
}

class InfoState extends State<Info> {
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
      appBar: AppBar(
        title: const Text("Kolibri"),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(pagesPadding),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Kolibri",
                style: TextStyle(
                  fontFamily: "CorporateS",
                  fontSize: 32,
                ),
              ),
              Text("NAO Challenge 2022.")
            ],
          ),
        ],
      ),
    );
  }
}
