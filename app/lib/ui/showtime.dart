import 'package:flutter/material.dart';

class Showtime extends StatelessWidget {
  const Showtime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ecco l'elicottero!"),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      body: Center(
        child: Image.asset("assets/gifs/gif.gif"),
      ),
    );
  }
}
