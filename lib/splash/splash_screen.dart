import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../config/route/app_routes.dart';
import '../services/storage/storage_services.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));

    bool isLogIn = LocalStorage.isLogIn;
    String kycStatus = LocalStorage.kycStatus;

    if (isLogIn) {
      if (kycStatus == 'approved') {
        debugPrint("===> User logged in & KYC approved. Going to Main Screen.");
        Get.offAllNamed(AppRoutes.main);
      } else {
        debugPrint("===> User logged in but KYC not approved ($kycStatus). Going to Subscription.");
        Get.offAllNamed(AppRoutes.subscriptionScreen);
      }
    } else {
      debugPrint("===> User not logged in. Going to Onboarding.");
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.black : Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
            colorFilter: isDark ? ColorFilter.mode(Colors.black.withValues(alpha: 0.6), BlendMode.darken) : null,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 3),
            Image.asset(
              AppImages.splash,
              height: 140.h,
              width: 140.w,
            ),
            SizedBox(height: 24.h),
            Image.asset(
              AppImages.sudo,
              width: 202.w,
              height: 40.h,
              color: isDark ? Colors.white : null,
            ),
            SizedBox(height: 24.h),
            Image.asset(
              AppImages.sudoText, 
              height: 9.h, 
              width: 285.w,
              color: isDark ? Colors.white70 : null,
            ),
            const Spacer(flex: 4),
            Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDark ? Colors.white : Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
