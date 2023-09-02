// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/menu_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isExpired = false;
  String text = "the description of the notification";
  String title = "New notification";
  var _color;
  void addNotification() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var i in value.docs) {
        if (i['plan'] != null) {
          if (i['plan']['planExpiry'] != null) {
            if (i['plan']['planExpiry']
                    .toDate()
                    .difference(DateTime.now())
                    .inDays <=
                5) {
              //add the notification to the firebase
              isExpired = true;
            }
          }
        }
      }
    });
    //add the notification to the firebase
  }

  //get the data from firebaseabout the expired date of the product

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: [
                const Text(
                  "Notification",
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
                                  uid:
                                      FirebaseAuth.instance.currentUser!.uid)));
                    },
                    icon: const Icon(
                      Icons.person_2_rounded,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                if (isExpired) {
                  title = "Plan Expity....";
                  text = "Your plan is going to expity in 5 days";
                }
                if (index < 3) {
                  _color = Colors.green;
                } else {
                  _color = Color.fromARGB(255, 246, 246, 246);
                }
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.grey[200],
                      ),
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(text),
                        trailing: Icon(
                          Icons.circle,
                          color: _color,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    )
                  ],
                );
              }),
        ));
  }
}
