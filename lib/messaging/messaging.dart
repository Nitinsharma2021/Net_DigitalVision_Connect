// ignore_for_file: prefer_const_constructors, unused_field, avoid_print, unused_import

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseAPI {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  static final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance
        .getInitialMessage()
        .then(handelMessage as FutureOr Function(RemoteMessage? value));

    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: 'launch_background',
          ),
        ),
        payload: message.data.toString(),
      );
    });
  }

  Future<void> initNotificatons() async {
    await FirebaseMessaging.instance.requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');
    print("FirebaseMessaging.onMessage");
    initPushNotifications();
    initLocalNotifications();
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('launch_background');
    const settings = InitializationSettings(android: android, iOS: null);

    await _localNotifications.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        print("$details helloworld");
        handelMessage(details as RemoteMessage);
      },
      onDidReceiveNotificationResponse: (details) {
        print("$details helloworld");
        handelMessage(details as RemoteMessage);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> handelMessage(RemoteMessage message) async {
    print("handeling messages");
    // print("Handling a foreground message");
    // print('Handling a foreground message ${message.messageId}');
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // print("Handling a background message");
    // print('Handling a background message ${message.messageId}');
  }
}
