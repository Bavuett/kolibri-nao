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
  Socket? socket;
  String? name;

  String ipAddress = "0.0.0.0";

  @override
  void initState() {
    String ipAddress = "0.0.0.0";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to your server"),
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
                        "What is the IP?",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "CorporateS",
                        ),
                      ),
                      Text(
                        "Enter the server's IP address below to connect. Make sure Wi-Fi is enabled.",
                      )
                    ],
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    ipAddress = value;
                    debugPrint(ipAddress);
                    debugPrint(isIP(ipAddress).toString());
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => Control(deviceIP: ipAddress)),
      ),
    );
  }

  void connectToServer() {
    Socket.connect("192.168.68.3", 8080).then((Socket sock) {
      socket = sock;
      socket!.listen(
        (data) {
          final serverResponse = String.fromCharCodes(data);
          print('Server: $serverResponse');
        },
      );
    });
  }

  void sendData() {
    socket!.write("SCEMOOO!");
  }
}
