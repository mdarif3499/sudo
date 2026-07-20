import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../config/route/app_routes.dart';
import '../services/storage/storage_services.dart';
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
    // স্প্ল্যাশ স্ক্রিন দেখানোর জন্য ৩ সেকেন্ড ওয়েট করবে
    await Future.delayed(const Duration(seconds: 3));

    // সরাসরি স্টোরেজ থেকে ডেটা চেক করা হচ্ছে
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
    return Scaffold(
      backgroundColor: Colors.white,
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
            ),
            SizedBox(height: 24.h),
            Image.asset(AppImages.sudoText, height: 9.h, width: 285.w),
            const Spacer(flex: 4),
            Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
