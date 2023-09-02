// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/complaints.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/util/snackBar.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'home.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  final complaintController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    complaintController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Complaints",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        toolbarHeight: 88,
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 15,
                      ),
                      margin: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Column(
                        children: [
                          textField(
                            hintText: "type complaint here",
                            inputType: TextInputType.name,
                            maxLines: 20,
                            controller: complaintController,
                          ),
                          CustomButton(
                            text: "Send",
                            onPressed: () {
                              storeComplaint();
                              // sendSms();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void storeComplaint() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ComplaintsModel complaintsModel = ComplaintsModel(
      createdAt: "",
      phoneNumber: "",
      uid: "",
      complaint: complaintController.text.trim(),
      email: "",
    );
    ap.saveUserComplaintToFirebase(
      context: context,
      complaintsModel: complaintsModel,
      onSuccess: () {
        ap.saveComplaintToSp();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        showSnackBar(context, "Complaint registered successfully");
      },
    );
  }

  Widget textField({
    required String hintText,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  void sendSms() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    TwilioFlutter twilioFlutter;
    twilioFlutter = TwilioFlutter(
      accountSid:
          'ACaa2e0655e82f9bc61e2eacf5a830dab2', // replace *** with Account SID
      authToken:
          '5875efb61c3e3cf4c04ca9dbde7bf432', // replace xxx with Auth Token
      twilioNumber: '+15153615770', // replace .... with Twilio Number
    );

    twilioFlutter.sendSMS(
      toNumber: '+919625348422',
      messageBody:
          "A new complaint has been raised by user Id: ${ap.userModel.uid} as: ${complaintController.text}",
    );
  }
}
