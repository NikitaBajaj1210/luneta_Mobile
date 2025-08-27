import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/helper.dart';
import 'network/app_url.dart';
import 'network/network_helper.dart';

class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('notification permission granted');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('notification provisional permission granted');
    }else{
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        Helper.shouldNavigateToNext = true;
      },
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    print('Notification message =====> ${message.data}');
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'Luneta Notifications',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Luneta notification description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    if(Platform.isAndroid) {
      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
        );
      });
    }
  }

  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {
      initLocalNotification(context, message);
      showNotification(message);
    });
  }

  Future<void> iosForegroundSettings() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );
  }

  Future<String> getFcmToken() async {
    return await messaging.getToken() ?? '';
  }

  void isTokenRefresh(){
    messaging.onTokenRefresh.listen((token) {
      print("FCM Refreshed Token:==========================> $token");
      NetworkHelper.fcmToken = token;
      checkToken();
    });
  }

  void checkToken() async {
    NetworkHelper().sendFcmTokenToServer();
  }
  }