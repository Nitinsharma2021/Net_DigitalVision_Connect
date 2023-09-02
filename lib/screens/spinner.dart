// ignore_for_file: unnecessary_const

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/SignUp.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 446,
      height: 957,
      decoration: const BoxDecoration(
          gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.white, Color(0xff60b4b4)],
      )),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text("RYTHYM",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(19, 129, 153, 1))),
              const Text("MULTIFY",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(19, 129, 153, 1))),
              const SizedBox(
                height: 16,
              ),
              const Text("5G INTERNET",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 189, 42, 1))),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  child: Image.asset("assets/images/center_logo_home.png"),
                ),
              ),
              Container()
            ],
          ),
          Positioned(
              top: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Image.asset("assets/images/Path 16curve.png"))),
          Positioned(
              top: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Image.asset("assets/images/Path 15curve.png"))),
          Positioned(
              top: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Image.asset("assets/images/Path 14curve.png"))),
          Positioned(
              top: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.48,
                  child: Image.asset("assets/images/Path 13curve.png"))),
          Positioned(
              top: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.54,
                  child: Image.asset("assets/images/Path 12curve.png"))),
          Positioned(
              top: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.62,
                  child: Image.asset("assets/images/Path 11curve.png"))),
          Positioned(
              top: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.71,
                  child: Image.asset("assets/images/Path 3curve.png"))),
          Positioned(
              bottom: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Image.asset("assets/images/home_bottom_logo.png"))),
        ],
      ),
    ));
  }
}
