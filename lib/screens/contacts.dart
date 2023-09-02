import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/util/snackBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 88,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Image(
              image: AssetImage("assets/images/help.png"),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 10, 8, 8),
              child: Text(
                "We are here to help you out, do feel free to contact us on following",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.phone,
                size: 40,
                color: Colors.black,
              ),
              title: const Text(
                'Phone',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                final Uri url = Uri(
                  scheme: 'tel',
                  path: '1234567890',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackBar(context, "cannot open dialer at the moment");
                }
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(
                Icons.email,
                size: 40,
                color: Colors.black,
              ),
              title: const Text(
                'Email',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'mycow@gmail.com',
                  query: encodeQueryParameters(
                    <String, String>{
                      'subject': 'type subject here',
                      'body': 'type body here',
                    },
                  ),
                );
                if (await canLaunchUrl(emailUri)) {
                  launchUrl(emailUri);
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackBar(context, "cannot open gmail at the moment");
                }
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(
                Icons.link,
                size: 40,
                color: Colors.black,
              ),
              title: const Text(
                'Instagram',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                const String url = 'https://instagram.com';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackBar(context, 'cannot open browser at the moment');
                }
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(
                Icons.link,
                size: 40,
                color: Colors.black,
              ),
              title: const Text(
                'Facebook',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                const String url = 'https://facebook.com';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackBar(context, 'cannot open browser at the moment');
                }
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(
                Icons.gps_fixed,
                size: 40,
                color: Colors.black,
              ),
              title: const Text(
                'Address',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                const String url = 'https://goo.gl/maps/QvZT1Wfz5w71tTt2A';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackBar(context, 'cannot open browser at the moment');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
