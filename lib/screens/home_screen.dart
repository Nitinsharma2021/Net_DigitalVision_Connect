// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/distributor_screen.dart';
import 'package:flutter_application_1/screens/menu_screen.dart';
import 'package:flutter_application_1/screens/plans_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imageList = [
    ['assets/images/one.png', 'OTT'],
    ['assets/images/two.png', 'Broadband'],
    ['assets/images/three.png', 'Cable']
  ];

  final List<List<dynamic>> plans = [
    [39900, "Nil", "30mbps"],
    [49900, "Nil", "30mbps"],
    [59900, "Nil", "30mbps"],
    [69900, "Nil", "100mbps"],
    [79900, "Nil", "100mbps"],
    [89900, "Nil", "100mbps"],
    [99900, "Nil", "150mbps"],
    [149900, "Nil", "300mbps"],
  ];

  final title = ['OTT', 'Broadband', 'Cable'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              const Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuScreen(
                                uid: FirebaseAuth.instance.currentUser!.uid)));
                  },
                  icon: const Icon(
                    Icons.person_2_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        toolbarHeight: 88,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.only(top: 18, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselSlider(
                items: imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PlansScreen()));
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Card(
                            color: Color.fromRGBO(237, 244, 246, 1),
                            elevation: 1.0, // Set the card elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the card border radius
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  imageUrl[0],
                                  fit: BoxFit.scaleDown,
                                  height: 200,
                                  width: 300, // Set the image width
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  imageUrl[1],
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 300.0, // Set the height of the carousel
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlansScreen()));
                  },
                  child: Text(
                    "Upgrade Your Plan",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  height: 200,
                  //color: Colors.black38,
                  child: CarouselSlider(
                    items: plans.map((plan) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              //color: Color.fromARGB(255, 255, 255, 255),
                              elevation: 1.0, // Set the card elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the card border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "₹${plan[0] / 100}",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlansScreen()));
                                              },
                                              child: Text(
                                                "Details",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Spacer(),
                                    CupertinoButton(
                                        minSize: null,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.blue,
                                        child: const Text("Recharge"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DistributorScreen(
                                                        price: plan[0],
                                                      )));
                                        })
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 250.0, // Set the height of the carousel
                      enlargeCenterPage: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                    ),
                  )),
              const Text(
                "  Your Current Plan\n",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Container(
                width: 400,

                //height: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Set the card border radius
                  ),
                  color: Color.fromRGBO(230, 239, 242, 1),
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Plan ID:- 7788",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  const Text(
                                    "300 Mbps",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    color: Color.fromRGBO(237, 244, 246, 1),
                                    child: const Text("Ulimited"),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                height: 100,
                                width: 140,
                                child: Card(
                                  color: Color.fromARGB(156, 0, 255, 225),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CircleAvatar(
                                        child: Icon(Icons.arrow_upward_rounded),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlansScreen()));
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlansScreen()));
                                          },
                                          child: Text(
                                            "UPGRADE\nPLAN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "\nExpires On- 31/08/2023\nData Usage- 101.09 MB",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              const Text(
                "\n\n  Refer a Friend!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(87, 172, 64, 191),
                ),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16, left: 8),
                        child: Text(
                          "Share with friends",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                        child: Text(
                          "Help Your Friends Explore the Speed of Rythym Multify",
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
