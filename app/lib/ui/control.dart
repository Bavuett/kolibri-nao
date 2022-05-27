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
        automaticallyImplyLeading: false,
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
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Halyard"),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.black,
                      ),
                      counter: Container(),
                      filled: true,
                      fillColor: Color.fromARGB(11, 0, 0, 0),
                      labelText: "Message",
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
        onPressed: disconnect,
        backgroundColor: color01,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: const Icon(Icons.wifi_off_rounded),
      ),
    );
  }

  void connect(String deviceIP) {
    Socket.connect(deviceIP, 8080).then((Socket sock) {
      socket = sock;
      if (socket == null) {
        debugPrint("Socket is Null");
      }
      socket!.listen(
        (data) {
          final serverResponse = String.fromCharCodes(data);
          debugPrint('Server: $serverResponse');
        },
      );
    });
  }

  void disconnect() {
    if (socket != null) {
      socket!.close();
    }
    Navigator.pop(context);
  }

  void sendData() {
    socket!.write("SCEMOOO!");
  }
}
