// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/distributor_screen.dart';
import 'package:flutter_application_1/screens/menu_screen.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final List<List<dynamic>> plans = [
    [39900, "Nil", "30mbps"],
    [49900, "Nil", "30mbps"],
    [59900, "Nil", "30mbps"],
    [69900, "Nil", "100mbps"],
    [79900, "Nil", "100mbps"],
    [89900, "Nil", "100mbps"], //update the validity also here
    [
      99900,
      "Nil",
      "150mbps"
    ], //add your plans here sample [price,'validity','speed'']
    [149900, "Nil", "300mbps"],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            children: [
              const Text(
                "Plans",
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
                            builder: (context) => MenuScreen(uid: "")));
                  },
                  icon: const Icon(
                    Icons.person_2_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        toolbarHeight: 88,
      ),
      body: ListView.builder(
          itemCount: 11,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Text("Trending Plans",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              );
            } else if (index == 1) {
              return CarouselSlider(
                items: plans.map((plan) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.grey[200],
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          //color: Color.fromARGB(255, 255, 255, 255),
                          elevation: 1.0, // Set the card elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Set the card border radius
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
                                          onTap: () {},
                                          child: Text(
                                            "Details",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Validity\n${plan[1]} days",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      "Data\nUnlimited@${plan[2]}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CupertinoButton(
                                    minSize: null,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    color: Colors.blue,
                                    child: const Text("Recharge"),
                                    onPressed: () {
                                      int amt = 0;
                                      setState(() {
                                        amt = plan[0];
                                      });
                                      print("Send to distributor ${amt}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DistributorScreen(
                                                    price: amt,
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                ),
              );
            } else if (index == 2) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Text("Other Plans",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              );
            }
            return buildCard(
                plans[index - 3][0], plans[index - 3][1], plans[index - 3][2]);
          }),
    );
  }

  Widget buildCard(int price, String validity, String speed) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Set the card border radius
        ),
        child: ListTile(
          title: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${price / 100}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Details",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Validity\n${validity} days",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    "Data\nUnlimited@${speed}",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CupertinoButton(
                  minSize: null,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  color: Colors.blue,
                  child: const Text("Recharge"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DistributorScreen(
                                  price: price,
                                )));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
