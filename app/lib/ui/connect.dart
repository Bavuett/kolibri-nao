import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kolibri/ui/control.dart';
import 'package:string_validator/string_validator.dart';

import 'package:kolibri/main.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => ConnectState();
}

class ConnectState extends State<Connect> {
  String deviceIP = "";

  @override
  void initState() {
    String deviceIP = "";
    debugPrint("Default IP: " + deviceIP);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connettiti a NAO"),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Qual è l'IP?",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "CorporateS",
                        ),
                      ),
                      Text(
                        "Inserisci l'IP di NAO qui sotto per connetterti. Assicurati che il Wi-Fi sia attivo e che tu sia collegato alla stessa rete di NAO.",
                      ),
                    ],
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    deviceIP = value;
                  },
                  maxLength: 15,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Halyard"),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.wifi,
                        color: Colors.black,
                      ),
                      counter: Container(),
                      filled: true,
                      fillColor: const Color.fromARGB(11, 0, 0, 0),
                      labelText: "Indirizzo IP di NAO",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Halyard",
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: beginConnection,
        backgroundColor: color01,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: const Icon(Icons.wifi),
      ),
    );
  }

  void beginConnection() {
    if (isIP(deviceIP) == true) {
      Socket.connect(deviceIP, 8080, timeout: const Duration(seconds: 5))
          .then((Socket sock) {
        Socket socket = sock;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => Control(socket: socket, deviceIP: deviceIP)),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        generateErrorSnackbar("Assicurati che l'IP sia valido!"),
      );
    }
  }
}
