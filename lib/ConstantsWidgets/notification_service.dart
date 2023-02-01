
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:monlivreur/ConstantsWidgets/firebase_options.dart';



class NotificationPluginService {


  late AndroidNotificationChannel androidNotificationChannel;
  late AndroidNotificationChannelGroup androidNotificationChannelGroup;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  NotificationPluginService.initNotificationsPlugin({bool fromBackground = false}) {
    _createAndroidChanel();
    if(!fromBackground) {
      _initFireBaseListener();
    }
    debugPrint('Handling Init Notifications Plugin');
  }

  Future<void> _initFireBaseListener() async {

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true,
    );

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      if (notification != null && android != null) {
        showDefaultNotification(message?.notification);
      }
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDefaultNotification(message.notification);
        print('Handling a background message ${message.data}');
      }
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDefaultNotification(message.notification);
      }
    });

  }


  _createAndroidChanel() {

    const String channelGroupId = 'App Notification';

    androidNotificationChannelGroup = const AndroidNotificationChannelGroup(
        channelGroupId, 'App Notification Group',
        description: 'App Notification Group Description');

    androidNotificationChannel = const AndroidNotificationChannel(
      'App Notification', 'App Notification',
      description: 'App Notification Description',
      groupId: channelGroupId,
    );

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannelGroup(androidNotificationChannelGroup);

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

  }


  Future<void> showDefaultNotification(RemoteNotification? notification) async {

    var iosChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: AndroidNotificationDetails(
      androidNotificationChannel.id, androidNotificationChannel.name,
      channelDescription: androidNotificationChannel.description, setAsGroupSummary: true,
        styleInformation: const BigTextStyleInformation(''), icon: 'logo_app'), iOS: iosChannelSpecifics);

    flutterLocalNotificationsPlugin.show(notification.hashCode, notification?.title,
        notification?.body, platformChannelSpecifics, payload: 'New Payload');
  }


  NotificationPluginService.cancelNotification() {
    flutterLocalNotificationsPlugin.cancel(0);
  }

  NotificationPluginService.cancelAllNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

}

