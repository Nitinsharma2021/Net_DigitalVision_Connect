// ignore_for_file: unused_element, avoid_print,, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/notification_services.dart';
import 'package:flutter_application_1/widgets/navbar.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    NotificationAPI().setTokenID();
    NotificationAPI().checkAndSend();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return Scaffold(
      bottomNavigationBar: NavBar(),
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
    );
  }

//   Widget imgBuild(String img, int index) {
//     return Container(
//       margin: const EdgeInsets.symmetric(
//         horizontal: 12,
//       ),
//       color: Colors.grey[300],
//       child: Column(
//         children: [
//           Image.asset(
//             img,
//             fit: BoxFit.fill,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomButton(
//             text: "Buy Now",
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const PayOptions(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({super.key});

//   @override
//   Widget build(context) => Drawer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             buildHeader(context),
//             buildMenuItems(context),
//           ],
//         ),
//       );

//   Widget buildHeader(context) {
//     final ap = Provider.of<AuthProvider>(context, listen: false);
//     return Container(
//       color: Colors.blue[300],
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).padding.top,
//       ),
//       height: 246,
//       child: Column(
//         children: [
//           const CircleAvatar(
//             radius: 60,
//             backgroundImage: AssetImage("assets/images/cow2.jpg"),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.fromLTRB(10, 0, 3, 0),
//           //   child: SizedBox(
//           //     height: 30,
//           //     child: Text(
//           //       ap.userModel.uid,
//           //       style: const TextStyle(fontSize: 25, color: Colors.white),
//           //     ),
//           //   ),
//           // ),
//           const SizedBox(height: 32),
//           SizedBox(
//             height: 30,
//             child: Text(
//               ap.userModel.phoneNumber,
//               style: const TextStyle(color: Colors.white, fontSize: 25),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildMenuItems(context) {
//     final ap = Provider.of<AuthProvider>(context, listen: false);
//     return Container(
//       color: Colors.grey[300],
//       padding: const EdgeInsets.all(24),
//       child: Wrap(
//         children: [
//           ListTile(
//             leading: const Icon(
//               Icons.account_circle,
//               size: 40,
//               color: Colors.black,
//             ),
//             title: const Text(
//               'Complaints',
//               style: TextStyle(fontSize: 20),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Complaints(),
//                 ),
//               );
//             },
//           ),
//           const Divider(color: Colors.black),
//           ListTile(
//             leading: const Icon(
//               Icons.home_outlined,
//               size: 40,
//               color: Colors.black,
//             ),
//             title: const Text(
//               'About Us',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const AboutUs(),
//                 ),
//               );
//             },
//           ),
//           const Divider(color: Colors.black),
//           ListTile(
//             leading: const Icon(
//               Icons.info,
//               size: 40,
//               color: Colors.black,
//             ),
//             title: const Text(
//               'Plans info',
//               style: TextStyle(fontSize: 20),
//             ),
//             onTap: () async {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Plans(),
//                 ),
//               );
//             },
//           ),
//           const Divider(color: Colors.black),
//           ListTile(
//             leading: const Icon(
//               Icons.account_balance_wallet_rounded,
//               size: 40,
//               color: Colors.black,
//             ),
//             title: const Text(
//               'Contact and Support',
//               style: TextStyle(fontSize: 20),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Contacts(),
//                 ),
//               );
//             },
//           ),
//           const Divider(color: Colors.black),
//           ListTile(
//             leading: const Icon(
//               Icons.account_circle,
//               size: 40,
//               color: Colors.black,
//             ),
//             title: const Text(
//               'FAQs',
//               style: TextStyle(fontSize: 20),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Faqs(),
//                 ),
//               );
//             },
//           ),
//           const Divider(color: Colors.black),
//           ListTile(
//             leading: const Icon(
//               Icons.exit_to_app_rounded,
//               size: 40,
//               color: Colors.black,
//             ),
//             title: const Text(
//               'Sign Out',
//               style: TextStyle(fontSize: 20),
//             ),
//             onTap: () {
//               ap.userSignOut();
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const SignUp(),
//                 ),
//               );
//               showSnackBar(context, "account sign out successfully");
//             },
//           ),
//         ],
//       ),
//     );
//   }
}
