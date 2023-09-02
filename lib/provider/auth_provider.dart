// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously, unused_import

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/messaging/messaging.dart';
import 'package:flutter_application_1/model/broadbandModel.dart';
import 'package:flutter_application_1/model/cableModel.dart';
import 'package:flutter_application_1/model/ottModel.dart';
import 'package:flutter_application_1/services/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/snackBar.dart';
import 'package:flutter_application_1/screens/otp.dart';
import 'package:flutter_application_1/model/userModel.dart';
import 'package:flutter_application_1/model/complaints.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPurchasedOtt = false;
  bool get isPurchasedOtt => _isPurchasedOtt;

  bool _isPurchasedCable = false;
  bool get isPurchasedCable => _isPurchasedCable;

  bool _isPurchasedBroadband = false;
  bool get isPurchasedBroadband => _isPurchasedBroadband;

  String? _uid;
  String get uid => _uid!;

  String? _email;
  String get email => _email!;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  ComplaintsModel? _complaintsModel;
  ComplaintsModel get complaintsModel => _complaintsModel!;

  OttModel? _ottModel;
  OttModel get ottModel => _ottModel!;

  CableModel? _cableModel;
  CableModel get cableModel => _cableModel!;

  BroadbandModel? _broadbandModel;
  BroadbandModel get broadbandModel => _broadbandModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future setExpiringOtt() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_purchased_ott", true);
    _isPurchasedOtt = true;
    notifyListeners();
  }

  Future deleteOtt() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_purchased_ott", false);
    _isPurchasedOtt = false;
  }

  Future setExpiringCable() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_purchased_cable", true);
    _isPurchasedCable = true;
    notifyListeners();
  }

  Future deleteCable() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_purchased_cable", false);
    _isPurchasedCable = false;
    notifyListeners();
  }

  Future setExpiringBroadband() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_purchased_broadband", true);
    _isPurchasedBroadband = true;
    notifyListeners();
  }

  Future deleteBroadband() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_purchased_broadband", false);
    _isPurchasedBroadband = false;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          print("verification completed");
          await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
        },
        verificationFailed: (error) {
          throw Exception(error.message.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Otp(verificationId: verificationId)));
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("Users").doc(_uid).get();
    if (snapshot.exists) {
      print("User exists");
      return true;
    } else {
      print("new user");
      return false;
    }
  }

  void saveUserDataToFirebase(
      {required BuildContext context,
      required UserModel userModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      userModel.uid = _firebaseAuth.currentUser!.uid;
      userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      userModel.email = _firebaseAuth.currentUser!.email!;

      _userModel = userModel;

      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.tomap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void saveUserComplaintToFirebase(
      {required BuildContext context,
      required ComplaintsModel complaintsModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      complaintsModel.createdAt =
          DateTime.now().millisecondsSinceEpoch.toString();
      complaintsModel.uid = _firebaseAuth.currentUser!.uid;
      complaintsModel.email = _firebaseAuth.currentUser!.email!;
      // complaintsModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;

      _complaintsModel = complaintsModel;

      await _firebaseFirestore
          .collection("complaints")
          .doc(_uid)
          .set(complaintsModel.tomap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        phoneNumber: snapshot['phoneNumber'],
        uid: snapshot['uid'],
      );
      _uid = userModel.uid;
    });
    return _userModel;
  }

  Future getUserData(uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc().get();
    return snapshot;
  }

  Future saveDataToSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "user_model",
      jsonEncode(
        userModel.tomap(),
      ),
    );
  }

  Future saveComplaintToSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "complaints_model",
      jsonEncode(
        userModel.tomap(),
      ),
    );
  }

  Future getDataFromSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? "";
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  void saveOttPlanDataToFirebase(
      {required BuildContext context,
      required OttModel ottModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      ottModel.createdAt = DateTime.now();
      ottModel.expAt = DateTime.now().add(const Duration(minutes: 5));
      ottModel.uid = _firebaseAuth.currentUser!.uid;
      ottModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;

      _ottModel = ottModel;

      await _firebaseFirestore
          .collection("ott")
          .doc(_uid)
          .set(ottModel.tomap())
          .then((value) {
        onSuccess();
        setExpiringOtt();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future saveOttDataToSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "ott_model",
      jsonEncode(
        userModel.tomap(),
      ),
    );
  }

  void saveCableDataToFirebase(
      {required BuildContext context,
      required CableModel cableModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      cableModel.createdAt = DateTime.now();
      cableModel.expAt = DateTime.now().add(const Duration(days: 30));
      cableModel.uid = _firebaseAuth.currentUser!.uid;
      cableModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;

      _cableModel = cableModel;

      await _firebaseFirestore
          .collection("cable")
          .doc(_uid)
          .set(userModel.tomap())
          .then((value) {
        onSuccess();
        setExpiringCable();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future savePaymentInfo() async {
    FirebaseFirestore.instance.collection("payment").doc(_uid).set({
      "uid": _uid,
      "email": _email,
      "createdAt": DateTime.now(),
      "phoneNumber": _firebaseAuth.currentUser!.phoneNumber!,
    });
  }

  Future saveCableDataToSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "cable_model",
      jsonEncode(
        userModel.tomap(),
      ),
    );
  }

  void saveBroadbandDataToFirebase(
      {required BuildContext context,
      required BroadbandModel broadbandModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      broadbandModel.createdAt = DateTime.now();
      broadbandModel.expAt = DateTime.now().add(const Duration(days: 30));
      broadbandModel.uid = _firebaseAuth.currentUser!.uid;
      broadbandModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;

      _broadbandModel = broadbandModel;

      await _firebaseFirestore
          .collection("broadband")
          .doc(_uid)
          .set(userModel.tomap())
          .then((value) {
        onSuccess();
        setExpiringBroadband();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future saveBroadbandDataToSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "broadband_model",
      jsonEncode(
        userModel.tomap(),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String res = "Something went wrong";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        UserModel user = UserModel(
            createdAt: DateTime.now().toString(),
            phoneNumber: "",
            uid: cred.user!.uid,
            email: email);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.tomap());
        print("User created ${cred.user!.uid}");
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        return 'email already in use';
      } else if (err.code == 'invalid-email') {
        return 'Incorrect email';
      } else if (err.code == 'weak-password') {
        return 'Password should be at least 6 characters';
      } else if (err.code == 'operation-not-allowed') {
        return 'Invalid email';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = 'something went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      res = "success";
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        return 'No user found for the given email.';
      } else if (err.code == 'wrong-password') {
        return 'Incorrect password';
      } else if (err.code == 'weak-password') {
        return 'Password should be at least 6 characters';
      } else if (err.code == 'invalid-email') {
        return 'Invalid email';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
