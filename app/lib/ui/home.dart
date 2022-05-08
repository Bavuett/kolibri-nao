import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolibri/main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Setting status and navigation bar colors.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: color01,
      systemNavigationBarColor: color02,
    ));

    return Scaffold(
      appBar: AppBar(
          title: const Text("Kolibri App"),
          centerTitle: true,
          elevation: 0,
          shape:
              const Border(bottom: BorderSide(width: 2, color: Colors.black))),
      body: const Center(child: Text("Hello, Kolibri!")),
    );
  }
}
