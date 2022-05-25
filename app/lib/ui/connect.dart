import 'dart:io';

import 'package:kolibri/main.dart';

import 'package:flutter/material.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => ConnectState();
}

class ConnectState extends State<Connect> {
  Socket? socket;
  String? name;

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
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text('Connect'),
            onPressed: () {
              connect();
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
