import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/dependency/dependency_injection.dart';
import 'config/route/app_routes.dart';
import 'firebase_options.dart';
import 'config/localization/languages.dart';
import 'services/localization/language_controller.dart';
import 'services/notification/notification_service.dart';
import 'services/storage/storage_keys.dart';
import 'services/storage/storage_services.dart';
import 'services/theme/theme_controller.dart';
import 'services/socket/socket_service.dart';
import 'utils/theme/app_theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  await LocalStorage.init();
  await NotificationService.init();
  SocketService.connect();

  // Inject LanguageController
  Get.put(LanguageController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SUDO',
          
          // Localization
          translations: Languages(),
          locale: Locale(LocalStorage.languageCode, LocalStorage.countryCode),
          fallbackLocale: const Locale('en', 'US'),
          
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          
          themeMode: themeController.themeMode,
          
          initialBinding: DependencyInjection(),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        ));
      },
    );
  }
}
