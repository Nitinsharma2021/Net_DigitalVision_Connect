import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Plans", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildCard(
              "assets/images/ott.jpg",
              "OTT",
              "30 days",
              "OTT is the most trending means of entertainment so don't lag behind and carry your own daily dose of tv shows, movies, series, all at the same place.",
              "1000",
              "swipe -->",
            ),
            buildCard(
              "assets/images/broadband.jpg",
              "Broadband",
              "30 days",
              "Broadband service is the best solution for your daily data needs. We care about safety and also value your money by providing speedy network at low cost.",
              "1000",
              "<-- swipe -->",
            ),
            buildCard(
              "assets/images/cable.jpg",
              "Cable Service",
              "30 days",
              "Cable service is meant for providing undisturbed network experience for your television and also at a reasonable cost.",
              "1000",
              "<-- swipe",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String address, String name, String validity,
      String description, String price, String direction) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Container(
        width: 320,
        height: 600,
        color: Colors.red,
        child: Column(
          children: [
            Image.asset(address),
            Text(
              name,
              style: const TextStyle(
                fontSize: 29,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$validity for $price rupees",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              direction,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
