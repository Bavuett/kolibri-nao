import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:kolibri/main.dart';

class DeviceSelect extends StatefulWidget {
  DeviceSelect({Key? key}) : super(key: key);

  @override
  DeviceSelectState createState() => DeviceSelectState();
}

class DeviceSelectState extends State<DeviceSelect> {
  FlutterBluePlus bluetooth = FlutterBluePlus.instance;
  List<ScanResult> scanResultList = [];
  bool isBluetoothScanning = false;

  @override
  initState() {
    super.initState();
    initBluetooth();
  }

  void initBluetooth() {
    bluetooth.isScanning.listen((isScanning) {
      isBluetoothScanning = isScanning;
      setState(() {});
    });
  }

  scan() async {
    if (!isBluetoothScanning) {
      scanResultList.clear();
      bluetooth.startScan(timeout: const Duration(seconds: 5));

      bluetooth.scanResults.listen((results) {
        scanResultList = results;
        setState(() {});
      });
    } else {
      bluetooth.stopScan();
    }
  }

  Widget deviceSignal(ScanResult r) {
    return Text(r.rssi.toString());
  }

  Widget deviceMAC(ScanResult r) {
    return Text(r.device.id.id);
  }

  Widget deviceName(ScanResult r) {
    String name = '';

    if (r.device.name.isNotEmpty) {
      name = r.device.name;
    } else if (r.advertisementData.localName.isNotEmpty) {
      name = r.advertisementData.localName;
    } else {
      name = 'N/A';
    }
    return Text(name, style: const TextStyle(fontFamily: "Halyard"));
  }

  Widget leading(ScanResult r) {
    return const CircleAvatar(
      radius: 25.5,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        child: Icon(
          Icons.bluetooth,
          color: Colors.black,
        ),
        backgroundColor: color01,
        radius: 24,
      ),
    );
  }

  void onTap(ScanResult r) {
    print('${r.device.name}');
  }

  Widget listItem(ScanResult r) {
    return ListTile(
      onTap: () => onTap(r),
      leading: leading(r),
      title: deviceName(r),
      subtitle: deviceMAC(r),
      trailing: deviceSignal(r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to your NAO"),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: scanResultList.length,
          itemBuilder: (context, index) {
            return listItem(scanResultList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        backgroundColor: color01,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: Icon(isBluetoothScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}
