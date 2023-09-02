// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationAPI {
  void checkAndSend() async {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var i in value.docs) {
        if (i['plan'] != null) {
          if (i['plan']['planExpiry'] != null) {
            if (i['plan']['planExpiry']
                    .toDate()
                    .difference(DateTime.now())
                    .inDays <=
                5) {
              sendNotification(token: i['token']);
            }
          }
        }
      }
    });
  }

  void setTokenID() async {
    try {
      final token =
          await FirebaseMessaging.instance.getToken().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'token': value.toString()});
      });
    } catch (e) {
      print(e);
    }
  }

  void sendNotification({
    required String token,
  }) async {
    var data = {
      'to': token.toString(),
      'priority': 'high',
      'notification': {
        'title': 'Plan Expity....',
        'body': 'Your plan is going to expity in 5 days'
      },
    };
    http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          "Content-Type": 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAUNzW2hA:APA91bHH-7g3AR6PtOA9vP64oX0_n2J4RAxjtffXkBMlnez0DnFEoAxsKTlqxXjoAH5_55Hi3JeNXb742syrRUzRgKHrnS2l-Ntyl0cyiRVU1EE_5GEXEK6R4SO4lUwhNSvtKh1II_mr'
        });
  }
}
