// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_string_interpolations, unused_element, avoid_print, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/broadbandModel.dart';
import 'package:flutter_application_1/model/cableModel.dart';
import 'package:flutter_application_1/model/ottModel.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/menu_screen.dart';
import 'package:flutter_application_1/util/snackBar.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

dynamic Price;

class DistributorScreen extends StatefulWidget {
  final int price;
  const DistributorScreen({
    super.key,
    required this.price,
  });
  @override
  State<DistributorScreen> createState() => _DistributorScreenState();
}

class _DistributorScreenState extends State<DistributorScreen> {
  int price = 0;

  static const distributor1 = 'rzp_test_h5pXO9jdiORQ2i';
  static const distributor2 = 'rzp_test_5mXQ9Z0Z1QXQ1a';
  String distributor = "";
  String id = "";
  String number = "";
  var items = <String>[];
  var distributors = [
    'distributor1',
    'distributor2',
    'distributor3',
    'distributor4',
    'distributor5',
    'distributor6',
    'distributor7',
    'distributor8',
    'distributor9',
    'distributor10',
    'distributor11',
    'distributor12',
    'distributor13',
  ];

  var keys = [
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
    distributor1,
  ];

  var mobile = [
    '1111111111',
    '2222222222',
    '3333333333',
    '1234567890',
    '0987654321',
    '7451234568',
    '7418529630',
    '7891236540',
    '4563217890',
    '8769867989',
    '7418514702',
    '8527894562',
    '7898524885',
  ];

  void _onSearch(String query) {
    setState(() {
      items = distributors
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    items = distributors;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Container(
          child: Row(
            children: [
              const Text(
                "Distributor Screen",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: ((value) {
                  print(value);
                  _onSearch(value);
                }),
                onTapOutside: (event) {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus
                        .unfocus(); // Unfocus the text field if it's focused
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: distributors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(items[index]), //name
                      onTap: () {
                        _showAlertDialog(widget.price, distributors[index],
                            mobile[index], keys[index]);
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAlertDialog(
      int price, String distributor, String number, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Confirm Pay'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to pay?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                print('setting state');
                setState(() {
                  price = widget.price;
                });
                _DistributorScreenState()
                    .handlepayment(price, distributor, number, id);
              },
            ),
          ],
        );
      },
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
    Provider.of<AuthProvider>(context, listen: false).savePaymentInfo();
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
    void handleExternalWalletSelected(ExternalWalletResponse response) {
      showSnackBar(context, "wallet name : ${response.walletName}");
    }

    sendSms();
    storeCableData();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showSnackBar(context, "wallet name : ${response.walletName}");
  }

  void handlepayment(
      int amt, String name, String contact, String Distributor_key) {
    print("entered handle payment");
    Razorpay razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponseBroadband);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    print("$amt this is the price");
    razorpay.open({
      'key': '$Distributor_key',
      'amount': amt,
      'name': '$name',
      'description': 'Purchase Service',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '$contact', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    });
  }
}
