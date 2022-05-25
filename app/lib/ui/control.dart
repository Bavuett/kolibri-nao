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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Control to your server"),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text('Control'),
            onPressed: () {
              connnect();
            },
          ),
          ElevatedButton(
            child: Text('Send Data'),
            onPressed: () {
              sendData();
            },
          ),
        ],
      ),
    );
  }

  void connect() {
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
