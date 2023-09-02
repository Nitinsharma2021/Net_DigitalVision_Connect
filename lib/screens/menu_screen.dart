// ignore_for_file: unnecessary_new, prefer_const_constructors, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/screens/aboutus.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/screens/complaints.dart';
import 'package:flutter_application_1/screens/contacts.dart';
import 'package:flutter_application_1/screens/faqs.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final String uid;
  const MenuScreen({super.key, required this.uid});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  void _showPopup(BuildContext context) async {
    TextEditingController accountController = new TextEditingController();
    TextEditingController amountController = new TextEditingController();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    //bool? _isNotValidate = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('your details'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: CircleAvatar(
                      radius: 78,
                      backgroundColor: Colors.white,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/images/Union.png",
                            fit: BoxFit.cover,
                          ),
                          Icon(
                            Icons.edit,
                            size: 32,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 48,
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "",
                        errorText: null,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 48,
                  child: TextField(
                    controller: accountController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "+91 9876543210",
                        errorText: null,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the popup
                },
                child: Text('Close'),
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('save'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    // DocumentSnapshot snapshot = ap.getUserData(widget.uid) as DocumentSnapshot;
    List<Widget> titles = [
      SizedBox(
        height: 12,
      ),
      ListTile(
        onTap: () {},
        leading: const CircleAvatar(
          radius: 32,
          child: Icon(
            Icons.person,
            size: 32,
          ),
        ),
        title: Text("", style: TextStyle(fontSize: 20)),
        subtitle: const Text("+91 9876543210", style: TextStyle(fontSize: 18)),
        trailing: IconButton(
          onPressed: () {
            _showPopup(context);
          },
          icon: const Icon(Icons.edit),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutUs()));
        },
        leading: const Icon(
          Icons.rocket,
          size: 24,
        ),
        title: const Text("About Us", style: TextStyle(fontSize: 18)),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Contacts()));
        },
        leading: const Icon(
          Icons.phone,
          size: 24,
        ),
        title: const Text(
          "Contact And Support",
          style: TextStyle(fontSize: 18),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Complaints()));
        },
        leading: const Icon(
          Icons.build,
          size: 24,
        ),
        title: const Text("Complaints and Service",
            style: TextStyle(fontSize: 18)),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Faqs()));
        },
        leading: const Icon(
          Icons.question_answer,
          size: 24,
        ),
        title: const Text("FAQs", style: TextStyle(fontSize: 18)),
      ),
      ListTile(
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        leading: const Icon(
          Icons.logout,
          size: 24,
          color: Colors.red,
        ),
        title: const Text("Log Out",
            style: TextStyle(fontSize: 18, color: Colors.red)),
      )
    ];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    child: titles[index],
                  ),
                  const Divider()
                ],
              );
            }),
      ),
    );
  }
}
