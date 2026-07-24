import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../config/route/app_routes.dart';

class NotificationService {
  NotificationService._();

  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static final _messaging = FirebaseMessaging.instance;

  static const String _channelId = 'sudo_high_importance_channel';
  static const String _channelName = 'SUDO Important Notifications';
  static const String _channelDescription = 'This channel is used for important app notifications.';

  /// Initialize all notification related services
  static Future<void> init() async {
    await _requestPermissions();
    await _initializeLocalNotifications();
    await _setupFCM();
  }

  /// Request permissions for Android 13+ and iOS
  static Future<void> _requestPermissions() async {
    // Local Notifications Permission
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();

    // Firebase Messaging Permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (kDebugMode) {
      print('🔔 User granted permission: ${settings.authorizationStatus}');
    }
  }

  /// Initialize local notification plugin
  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Create Android channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(channel);
  }

  /// Setup Firebase Messaging handlers
  static Future<void> _setupFCM() async {
    // Get Device Token
    String? token = await _messaging.getToken();
    if (kDebugMode) {
      print('🚀 FCM Device Token: $token');
    }

    // Handle Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('📩 Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        show(
          title: message.notification!.title ?? 'New Notification',
          body: message.notification!.body ?? '',
          payload: message.data.toString(),
        );
      }
    });

    // Handle Background/Terminated Click
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('🖱️ Notification clicked from background!');
      }
      _handleNavigation(message.data);
    });
  }

  /// Handle notification tap for local notifications
  static void _onNotificationTap(NotificationResponse response) {
    if (kDebugMode) {
      print('🖱️ Local notification tapped: ${response.payload}');
    }
    Get.toNamed(AppRoutes.notification);
  }

  /// Navigate based on payload
  static void _handleNavigation(Map<String, dynamic> data) {
    // You can add custom logic here based on payload data
    Get.toNamed(AppRoutes.notification);
  }

  /// Show a local heads-up notification
  static Future<void> show({
    required String title,
    required String body,
    String? payload,
    String? imageUrl,
  }) async {
    final notificationId = Random().nextInt(100000);
    
    // Modern Big Text Style or Image support
    BigTextStyleInformation? bigTextStyleInformation;
    if (body.length > 40) {
      bigTextStyleInformation = BigTextStyleInformation(
        body,
        contentTitle: title,
        summaryText: 'New Message',
      );
    }

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      styleInformation: bigTextStyleInformation,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
