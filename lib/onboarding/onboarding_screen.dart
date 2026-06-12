import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../component/button/common_button.dart';
import '../component/text/common_text.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_icons.dart';
import '../config/route/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': AppImages.onboarding1,
      'title': 'Join Savings Circles',
      'subtitle':
          'Create or join savings groups with trusted\nfriends and family to achieve your financial\ngoals together.',
    },
    {
      'image': AppImages.onboarding2,
      'title': 'Secure & Trusted',
      'subtitle':
          'Your money is safe with bank-level security\nand transparent tracking of every\ncontribution.',
    },
    {
      'image': AppImages.onboarding3,
      'title': 'Achieve Your Goals',
      'subtitle':
          'Build savings habits, reach milestones faster,\nand celebrate success with your circle.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section with PageView for Image, Title, and Subtitle
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      // Illustration
                      Image.asset(
                        _onboardingData[index]['image']!,
                        height: 140.h,
                        width: 140.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 40.h),
                      // Title
                      CommonText(
                        text: _onboardingData[index]['title']!,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CommonText(
                          text: _onboardingData[index]['subtitle']!,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondaryColor,
                          textAlign: TextAlign.center,
                          height: 1.5,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // FIXED INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 6.h,
                  width: _currentPage == index ? 26.w : 8.w,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.indicatorActive
                        : AppColors.indicatorInactive,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),

            const Spacer(flex: 2),

            // Bottom Buttons Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  CommonButton(
                    iconPath: AppIcons.arrowR,
                    titleText: 'Next',
                    gradient: AppColors.primaryGradient,
                    showIcon: true,
                    onTap: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to Auth Screen
                        Get.offAllNamed(AppRoutes.auth);
                      }
                    },
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () {
                      // Navigate to Auth Screen
                      Get.offAllNamed(AppRoutes.auth);
                    },
                    child: CommonText(
                      text: 'Skip',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
