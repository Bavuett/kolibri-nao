// ignore_for_file: unnecessary_this
import 'dart:io';

import 'package:kolibri/main.dart';
import 'package:kolibri/ui/showtime.dart';

import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  // Require Socket and IP as the page's parameters.
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
    // Begin listening for messages from the server when the
    // page is loaded.
    this.listen(widget.socket);
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
                          "Connesso!",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "CorporateS",
                          ),
                        ),
                        Text(
                          "Sei connesso a NAO. Invia dei messaggi!",
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
                        labelText: "Messaggio",
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
                    child: const Text("Invia"),
                  ),
                  Container(padding: const EdgeInsets.symmetric(vertical: 10)),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Cosa posso dire?",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "CorporateS",
                          ),
                        ),
                        Text("NAO comprende i seguenti comandi:"),
                        Text(" - Quando sei nato?"),
                        Text(" - Dove sei nato?"),
                        Text(" - Dove abitavi?"),
                        Text(" - Quali sono state le tue creazioni?"),
                        Text(" - Mostrami il tuo elicottero"),
                      ],
                    ),
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
      generateSnackbar("Ho inviato a NAO: " + message),
    );
  }

  void listen(Socket socket) async {
    socket.listen(
      (data) {
        debugPrint("Server responded: " + String.fromCharCodes(data));
        String response = String.fromCharCodes(data);
        ScaffoldMessenger.of(context).showSnackBar(
          generateSnackbar("NAO mi ha inviato: " + response),
        );

        if (response == "showtime") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (((context) => const Showtime())),
              maintainState: true,
            ),
          );
        }
      },

      // Code to call on server error.
      onError: (serverError) {
        debugPrint("Ho cacato: " + serverError);
        socket.destroy();
        ScaffoldMessenger.of(context).showSnackBar(
          generateErrorSnackbar(
            "Whoops! Ho dovuto disconettermi da NAO a causa di un errore.",
          ),
        );
        Navigator.pop(context);
      },

      // Code to call on server disconnection.
      onDone: () {
        this.disconnect(socket);
      },
    );
  }

  void disconnect(Socket socket) {
    socket.write("close");
    socket.close();
    ScaffoldMessenger.of(context).showSnackBar(
      generateErrorSnackbar(
        "Mi sono disconnesso da NAO. Il server è stato chiuso.",
      ),
    );
    Navigator.pop(context);
  }
}
