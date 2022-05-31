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
    // ignore: unused_local_variable
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Informazioni su Kolibri"),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Kolibri: NAO Challenge 2022",
                style: TextStyle(
                  fontFamily: "CorporateS",
                  fontSize: 24,
                ),
              ),
              const Text("v1.0"),
              Container(padding: const EdgeInsets.symmetric(vertical: 5)),
              const Divider(),
              Container(padding: const EdgeInsets.symmetric(vertical: 5)),
              const Text(
                  "Kolibri è l'app del team Kolibri della NAO Challenge 2022. Questa app ti permette di controllare il robot NAO nella sfida finale."),
              Container(padding: const EdgeInsets.symmetric(vertical: 10)),
              const Text(
                  "Collegati a NAO utilizzando il suo Indirizzo IP, chatta con lui, e divertiti scoprendo la storia di Corradino d'Ascanio con NAO!"),
            ],
          ),
        ],
      ),
    );
  }
}
