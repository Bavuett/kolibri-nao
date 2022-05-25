import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:kolibri/main.dart';

class Device extends StatefulWidget {
  const Device({Key? key, required this.device}) : super(key: key);

  // Creating variable to store the Bluetooth device.
  final BluetoothDevice device;

  @override
  State<Device> createState() => DeviceState();
}

class DeviceState extends State<Device> {
  FlutterBluePlus bluetooth = FlutterBluePlus.instance;

  String deviceConnectionText = 'Connecting...';
  String connectButtonText = 'Disconnect';

  BluetoothDeviceState deviceConnection = BluetoothDeviceState.disconnected;

  StreamSubscription<BluetoothDeviceState>? stateListener;

  @override
  void initState() {
    super.initState();
    stateListener = widget.device.state.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
