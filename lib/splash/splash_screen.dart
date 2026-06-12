import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../config/route/app_routes.dart';
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
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,

          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 3),
            // Logo Image
            Image.asset(
              AppImages.splash,
              height: 140.h,
              width: 140.w,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 100.h,
                  color: Colors.grey.withValues(alpha: 0.5),
                );
              },
            ),
            SizedBox(height: 24.h),
            // App Name "SUDO"
            Image.asset(
              AppImages.sudo,
              width: 202.w,
              height: 40.h,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 100.h,
                  color: Colors.grey.withValues(alpha: 0.5),
                );
              },
            ),
            SizedBox(height: 24.h),
            // Tagline
            Image.asset(AppImages.sudoText, height: 9.h, width: 285.w),
            const Spacer(flex: 4),
            // Subtle Loading Indicator
            Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: SizedBox(
                width: 22.w,
                height: 22.h,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
