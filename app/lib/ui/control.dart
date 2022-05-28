// ignore_for_file: unnecessary_this

import 'dart:io';

import 'package:kolibri/main.dart';

import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  const Control({Key? key, required this.socket, required this.deviceIP})
      : super(key: key);

  @override
  State<Control> createState() => ControlState();

  final Socket socket;

  final String deviceIP;
}

class ControlState extends State<Control> {
  String ipAddress = "0.0.0.0";
  String message = "Default Message";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Socket socket = widget.socket;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.deviceIP),
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
            padding: const EdgeInsets.all(20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 15),
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
                      message = value;
                    },
                    style: const TextStyle(
                        color: Colors.black, fontFamily: "Halyard"),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Colors.black,
                        ),
                        counter: Container(),
                        filled: true,
                        fillColor: const Color.fromARGB(11, 0, 0, 0),
                        labelText: "Message",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Halyard",
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sendToServer(socket, message);
                    },
                    child: const Text("Send"),
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            this.disconnect(socket);
          },
          backgroundColor: color01,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: const CircleBorder(
            side: BorderSide(color: Colors.black, width: 2),
          ),
          child: const Icon(Icons.wifi_off_rounded),
        ),
      ),
    );
  }

  void sendToServer(Socket socket, String message) {
    debugPrint("Sending to server: " + message);
    socket.write(message);
    ScaffoldMessenger.of(context).showSnackBar(
      generateSnackbar("Sent to Server: " + message),
    );

    socket.listen((data) {
      debugPrint("Server responded: " + String.fromCharCodes(data));
      String response = String.fromCharCodes(data);
      ScaffoldMessenger.of(context).showSnackBar(
        generateSnackbar("Server sent me: " + response),
      );
    });

    socket.handleError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        generateSnackbar("Whoops! " + err),
      );
      Navigator.pop(context);
    });
  }

  void disconnect(Socket socket) {
    socket.write("close");
    ScaffoldMessenger.of(context).showSnackBar(
      generateSnackbar("Disconnecting to server and closing it."),
    );
    socket.close();
    Navigator.pop(context);
  }
}
