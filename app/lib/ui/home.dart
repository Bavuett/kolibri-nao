import 'package:flutter/material.dart';
import 'package:kolibri/main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Patrick Scem"),
        ),
        body: ListView(
          children: const [Center(child: Text("Patrick Scem"))],
        ));
  }
}
