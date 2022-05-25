import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kolibri/main.dart';
import 'package:kolibri/ui/control.dart';
import 'package:kolibri/ui/info.dart';

int currentIndex = 0;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Setting status and navigation bar colors.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: color01,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    // Getting the Screen Size.
    Size screenSize = MediaQuery.of(context).size;

    // Pages displayed by the app, which can be changed from the Bottom
    // Navigation Bar. These can be edited in /ui/pages/.
    final appPages = [
      Connect(),
      const Info(),
    ];

    return Scaffold(
      // What the app will show. Indexed Stack saves all the pages so they keep
      // their state while they are not being used.
      body: IndexedStack(
        index: currentIndex,
        children: appPages,
      ),

      // Bottom Navigation Bar setup.
      bottomNavigationBar: Container(
        // Decorating the Navigation Bar with a border.
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 2, color: Colors.black)),
          color: color01,
        ),
        padding: const EdgeInsets.all(6.5),
        // Setting the Bottom Navigation Bar as the container's child
        // and setting it up.
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: color01,
          currentIndex: currentIndex,
          elevation: 0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(fontFamily: "Halyard"),
          unselectedLabelStyle: const TextStyle(fontFamily: "Halyard"),
          // Bottom Navigation Bar icons.
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_people_rounded),
              label: "Robot",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded),
              label: "About",
            ),
          ],
          onTap: (index) => setState(() => currentIndex = index),
        ),
      ),
    );
  }
}
