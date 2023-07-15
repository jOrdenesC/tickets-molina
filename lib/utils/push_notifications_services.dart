import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';

class PushNotificationsServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStream.stream;

  static Future<void> _onBackgroundHandler(RemoteMessage message) async {
    print('onBackground Handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    // Crear una instancia de InAppNotifications
    print('onMessage Handler ${message.data}');
    InAppNotifications.show(
        title: message.notification?.title ?? 'No title',
        leading: const Icon(
          Icons.fact_check,
          color: Colors.green,
          size: 50,
        ),
        ending: const Icon(
          Icons.arrow_right_alt,
          color: Colors.red,
        ),
        description: message.notification?.body ?? 'No description', // optional
        onTap: () {
          // Do whatever you need!
        });
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp Handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future initializeApp() async {
    //push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //handlers
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);

    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}


