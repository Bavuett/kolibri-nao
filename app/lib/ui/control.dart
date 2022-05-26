import 'dart:io';

import 'package:kolibri/main.dart';

import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  const Control({Key? key, required this.deviceIP}) : super(key: key);

  @override
  State<Control> createState() => ControlState();

  final String deviceIP;
}

class ControlState extends State<Control> {
  Socket? socket;
  String? name;

  String ipAddress = "0.0.0.0";
  String message = "Default Message";

  @override
  void initState() {
    ipAddress = widget.deviceIP;
    connect(ipAddress);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ipAddress),
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
          padding: EdgeInsets.all(20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Connected!",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "CorporateS",
                        ),
                      ),
                      Text(
                        "You're connected to the server. Send some messages!",
                      )
                    ],
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    ipAddress = value;
                    debugPrint(ipAddress);
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
                      fillColor: Color.fromARGB(11, 0, 0, 0),
                      labelText: "Server's IP address",
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
    );
  }

  void connect(String deviceIP) {
    const snackbar = SnackBar(content: Text("Connected!"));

    Socket.connect(deviceIP, 8080).then((Socket sock) {
      socket = sock;
      socket!.listen(
        (data) {
          final serverResponse = String.fromCharCodes(data);
          print('Server: $serverResponse');
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        },
      );
    });
  }

  void sendData() {
    socket!.write("SCEMOOO!");
  }
}
