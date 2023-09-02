import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/model/userModel.dart';

class Tnc extends StatefulWidget {
  const Tnc({super.key});

  @override
  State<Tnc> createState() => _TncState();
}

class _TncState extends State<Tnc> {
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
        backgroundColor: Colors.black,
        title: const Text(
          "Confirmation",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        toolbarHeight: 88,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 430,
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/welcome.jpg'),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Center(
              child: Text(
                "The sign in was successful",
                style: TextStyle(
                  color: Color.fromRGBO(20, 156, 140, 1),
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
            child: Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                    text: "Continue",
                    onPressed: () {
                      storeData();
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      email: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    ap.saveUserDataToFirebase(
      context: context,
      userModel: userModel,
      onSuccess: () {
        ap.saveDataToSp().then(
              (value) => ap.setSignIn().then(
                    (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                        (route) => false),
                  ),
            );
      },
    );
  }
}
