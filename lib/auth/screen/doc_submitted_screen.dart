import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_icons.dart';
import '../../../config/route/app_routes.dart';

class DocSubmittedScreen extends StatefulWidget {
  const DocSubmittedScreen({super.key});

  @override
  State<DocSubmittedScreen> createState() => _DocSubmittedScreenState();
}

class _DocSubmittedScreenState extends State<DocSubmittedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    Timer(const Duration(seconds: 4), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    AppIcons.submitted,
                    height: 120.h,
                    width: 120.w,
                    // If the icon is a black/dark asset, you might want to tint it for dark mode
                    // color: isDark ? Colors.white : null, 
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: Container(
                      height: 10.h,
                      width: 75.w,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          value: _animation.value,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFF6C92F4).withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              const CommonText(
                text: "Documents Submitted Successfully",
                fontSize: 22,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              CommonText(
                text:
                    "We've received your documents and they're now being reviewed. Please sit tight while we verify your information. We'll notify you as soon as the review is complete.",
                fontSize: 14,
                color: isDark ? Colors.white70 : AppColors.textSecondaryColor,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
