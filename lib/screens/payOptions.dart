// ignore_for_file: file_names, avoid_print, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/model/broadbandModel.dart';
import 'package:flutter_application_1/model/cableModel.dart';
import 'package:flutter_application_1/model/ottModel.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'package:flutter_application_1/util/snackBar.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class PayOptions extends StatefulWidget {
  const PayOptions({super.key});

  @override
  State<PayOptions> createState() => _PayOptionsState();
}

class _PayOptionsState extends State<PayOptions> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  static const key1 = 'rzp_test_h5pXO9jdiORQ2i';
  static const key2 = 'rzp_test_LfZWmsfbp04Op9';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: const Text(
          "Plans",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
        toolbarHeight: 88,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            textField(
              hintText: "type broadcaster number here",
              inputType: TextInputType.name,
              maxLines: 2,
              controller: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            buildCard(
              "assets/images/ott.jpg",
              "OTT",
              "30 days",
              "OTT is the most trending means of entertainment so don't lag behind and carry your own daily dose of tv shows, movies, series, all at the same place.",
              "1000",
            ),
            CustomButton(
              text: "Buy Ott",
              onPressed: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': nameController.text == "1" ? key1 : key2,
                  'amount': 1000,
                  'name': 'My Cow',
                  'description': 'Purchase Service',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponseOtt);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            buildCard(
              "assets/images/broadband.jpg",
              "Broadband",
              "30 days",
              "Broadband service is the best solution for your daily data needs. We care about safety and also value your money by providing speedy network at low cost.",
              "2000",
            ),
            CustomButton(
              text: "Buy Broadband",
              onPressed: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': nameController.text == "1" ? key1 : key2,
                  'amount': 2000,
                  'name': 'My Cow',
                  'description': 'Purchase Service',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponseBroadband);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            buildCard(
              "assets/images/cable.jpg",
              "Cable Service",
              "30 days",
              "Cable service is meant for providing undisturbed network experience for your television and also at a reasonable cost.",
              "3000",
            ),
            CustomButton(
              text: "Buy Cable",
              onPressed: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': nameController.text == "1" ? key1 : key2,
                  'amount': 3000,
                  'name': 'My Cow',
                  'description': 'Purchase Service',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponseCable);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
            ),
          ],
        ),
      ),
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

  var send = false;

  void sendAlert() {
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
      toNumber: ap.userModel.phoneNumber,
      messageBody: "Please check subscription status.",
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
      toNumber: ap.userModel.phoneNumber,
      messageBody: "New subscription has been added successfully",
    );
  }

  void storeOttData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    OttModel ottModel = OttModel(
      email: ap.email,
      createdAt: DateTime.now(),
      expAt: DateTime.now().add(
        const Duration(minutes: 5),
      ),
      phoneNumber: "",
      uid: "",
    );
    ap.saveOttPlanDataToFirebase(
      context: context,
      ottModel: ottModel,
      onSuccess: () {
        ap.saveOttDataToSp();
      },
    );
  }

  void storeCableData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    CableModel cableModel = CableModel(
      createdAt: DateTime.now(),
      expAt: DateTime.now().add(
        const Duration(days: 30),
      ),
      phoneNumber: "",
      uid: "",
      email: "",
    );
    ap.saveCableDataToFirebase(
      context: context,
      cableModel: cableModel,
      onSuccess: () {
        ap.saveCableDataToSp();
      },
    );
  }

  void storeBroadbandData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    BroadbandModel broadbandModel = BroadbandModel(
      email: ap.email,
      createdAt: DateTime.now(),
      expAt: DateTime.now().add(
        const Duration(days: 30),
      ),
      phoneNumber: "",
      uid: "",
    );
    ap.saveBroadbandDataToFirebase(
      context: context,
      broadbandModel: broadbandModel,
      onSuccess: () {
        ap.saveBroadbandDataToSp();
      },
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showSnackBar(context, "payment failed: ${response.message}");
  }

  void handlePaymentSuccessResponseOtt(PaymentSuccessResponse response) {
    showSnackBar(context, "payment successful : ${response.paymentId}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
    sendSms();
    storeOttData();
  }

  void handlePaymentSuccessResponseBroadband(PaymentSuccessResponse response) {
    showSnackBar(context, "payment successful : ${response.paymentId}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
    sendSms();
    storeBroadbandData();
  }

  void handlePaymentSuccessResponseCable(PaymentSuccessResponse response) {
    showSnackBar(context, "payment successful : ${response.paymentId}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
    sendSms();
    storeCableData();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showSnackBar(context, "wallet name : ${response.walletName}");
  }

  Widget buildCard(String address, String name, String validity,
      String description, String price) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(62, 186, 235, 1),
        ),
        width: 320,
        height: 600,
        
        child: Column(
          children: [
            Image.asset(address),
            Text(
              name,
              style: const TextStyle(
                fontSize: 29,
                color: Colors.black,
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
                color: Colors.black,
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
