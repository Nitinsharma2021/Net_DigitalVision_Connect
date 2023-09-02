// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/menu_screen.dart';
import 'package:flutter_application_1/screens/notification_screen.dart';
import 'package:flutter_application_1/screens/plans_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  List<Widget> screens = [
    //
    HomeScreen(),
    NotificationScreen(),
    PlansScreen(),
    MenuScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];
  List<Widget> titles = [];

  @override
  void initState() {
    titles = [
      Container(
        color: Colors.grey,
        child: Row(
          children: [
            const Text(
              "Home",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Expanded(child: Container()),
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color.fromARGB(96, 199, 199, 199),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                  icon: const Icon(
                    Icons.person_2,
                    size: 32,
                  )),
            ),
          ],
        ),
      ),
      Row(
        children: [
          SizedBox(
            width: 16,
          ),
          const Text(
            "Notification",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(child: Container()),
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color.fromARGB(96, 199, 199, 199),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: const Icon(
                  Icons.person_2,
                  size: 32,
                )),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 16,
          ),
          const Text(
            "Our Plans",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(child: Container()),
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color.fromARGB(96, 199, 199, 199),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: const Icon(
                  Icons.person_2,
                  size: 32,
                )),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      const Text(
        "Menu",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     toolbarHeight: 88,
      //     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //     elevation: 0,
      //     title: titles[currentIndex]),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: 2,
        selectedFontSize: 14,
        selectedItemColor: const Color.fromARGB(255, 36, 147, 136),
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        unselectedItemColor: const Color.fromARGB(167, 175, 175, 175),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 32,
              ),
              label: "Home",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 32,
              ),
              label: "notifications",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mobile_friendly,
                size: 32,
              ),
              label: "plans",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              size: 32,
            ),
            label: "menu",
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
