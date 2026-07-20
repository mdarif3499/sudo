import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/dependency/dependency_injection.dart';
import 'config/route/app_routes.dart';
import 'services/storage/storage_services.dart';
import 'services/theme/theme_controller.dart';
import 'utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // স্টোরেজ ইনিশিয়ালাইজ করা হলো
  await LocalStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeController ইনজেক্ট করা হচ্ছে
    final themeController = Get.put(ThemeController());

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        // Obx ব্যবহার করা হয়েছে যাতে থিম চেঞ্জ হলে পুরো অ্যাপ আপডেট হয়
        return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SUDO',
          
          // লাইট এবং ডার্ক থিম সেটআপ
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          
          // কন্ট্রোলার থেকে থিম মোড নেওয়া হচ্ছে
          themeMode: themeController.themeMode,
          
          initialBinding: DependencyInjection(),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        ));
      },
    );
  }
}
