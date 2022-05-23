import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kolibri/main.dart';

import 'package:flutter_blue/flutter_blue.dart';

class DeviceSelect extends StatefulWidget {
  const DeviceSelect({Key? key}) : super(key: key);

  @override
  DeviceSelectState createState() => DeviceSelectState();
}

class DeviceSelectState extends State<DeviceSelect> {
  @override
  Widget build(BuildContext context) {
    // Setting status and navigation bar colors.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: color01,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    // Getting the Screen Size.
    Size screenSize = MediaQuery.of(context).size;

    String bluetoothState;

    FlutterBlue bluetooth = FlutterBlue.instance;

    if (bluetooth.isOn == true) {
      bluetoothState = "enabled";
    } else {
      bluetoothState = "disabled";
    }

    bluetooth.startScan(timeout: Duration(seconds: 5));

    var devices = bluetooth.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

    bluetooth.stopScan();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to NAO"),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(pagesPadding),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Connect to NAO",
                style: TextStyle(
                  fontFamily: "CorporateS",
                  fontSize: 32,
                ),
              ),
              Text("Bluetooth is ${bluetoothState}")
            ],
          ),
        ],
      ),
    );
  }
}
