import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("===== Background Message Received =====");
  print("Message ID: ${message.messageId}");
  print("Data: ${message.data}");
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
}

class InitServices {
  static late SharedPreferences sharedPref;
  static late FirebaseMessaging messaging;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    try {
      // 1. Initialize SharedPreferences
      sharedPref = await SharedPreferences.getInstance();

      // 2. Initialize Firebase
      if (Platform.isAndroid) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBMy968UAI1YI71Mg2vHQikFqNEDra4_o8",
            appId: "1:819905247319:android:e3ca26157456e518010b12",
            messagingSenderId: "819905247319",
            projectId: "fluttercourse-5af65",
          ),
        );
      } else {
        await Firebase.initializeApp();
      }

      // 3. Setup Firebase Messaging
      messaging = FirebaseMessaging.instance;
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // 4. Setup local notifications
      await _initLocalNotifications();

      // 5. Request permissions and get token
      await _setupNotificationPermissions();
      // 6. Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("===== Foreground Message Received =====");

        final notification = message.notification;
        final android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'channel_id',
                'channel_name',
                channelDescription: 'Your channel description',
                importance: Importance.max,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      });
      // 7. Handle tap on notification
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("===== Notification Tapped =====");
        print("Data: ${message.data}");
      });

      // 8. Subscribe to topic
      await FirebaseMessaging.instance.subscribeToTopic('news');

      print('✅ All services initialized successfully');
    } catch (e) {
      print('❌ Error initializing services: $e');
      rethrow;
    }
  }

  static Future<void> _setupNotificationPermissions() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // iOS foreground permission
    if (Platform.isIOS) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    final token = await messaging.getToken();
    print('🔐 FCM Token: $token');
  }

  static Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }
}
