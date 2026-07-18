import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryColor = Color(0xFF080808);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFF000000);

  // Dark Mode Specific Colors
  static const Color darkCardBg = Color(0xFF01052B);
  static const Color darkCardBorder = Color(0xFF13295C);

  // Button Gradient Colors from Screenshot
  static const Color gradientColor1 = Color(0xFF04A1CD);
  static const Color gradientColor2 = Color(0xFF068FD8);
  static const Color gradientColor3 = Color(0xFF067DD6);
  static const Color gradientColor4 = Color(0xFF3643D0);

  static const Gradient primaryGradient = LinearGradient(
    colors: [
      gradientColor1,
      gradientColor2,
      gradientColor3,
      gradientColor4,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Onboarding Gradient
  static const Color buttonGradientStart = Color(0xFF00ADEF);
  static const Color buttonGradientEnd = Color(0xFF3B44D1);
  static const Color indicatorActive = Color(0xFF48C8FC);
  static const Color indicatorInactive = Color(0xFFE0E0E0);
  
  // Splash Screen
  static const Color splashTaglineGreen = Color(0xFF19CA77);
  static const Color splashBackgroundStart = Color(0xFFE8F9FF);
  static const Color splashBackgroundEnd = Color(0xFFFFF5F5);

  // Existing colors maintained for compatibility
  static const Color colorB6A0FF = Color(0xFFB6A0FF);
  static const Color color2F80ED = Color(0xFF2F80ED);
  static const Color textPrimary = Color(0xFF242424);
  static const Color color19CA77 = Color(0xff19CA77);
  static const Color textSecondary   = Color(0xFF7C7C7C);
  static const Color color3F3F3 = Color(0xFFF3F3F3);
  static const Color color373737 = Color(0xFF373737);
  static const Color colorFFB2 = Color(0xFFFFFFB2);
  static const Color color6A7282 = Color(0xFF6A7282);
  static const Color colorEABB00 = Color(0xFFEABB00);
  static const Color logoutRed = Color(0xFFA53200);
  static const Color iconBgYellow = Color(0xFFFFF8E1);
  static const Color transparent = Colors.transparent;
  static const Color textSecondaryColor = Color(0xFF6A7282);
  static const Color textSecondaryColor7C7C7C = Color(0xFF7C7C7C);
  static const Color textPrimaryColor = Color(0xFF121212);
  static const Color text6BD45 = Color(0xFFE6BD45);
  static const Color color333333 = Color(0xFF333333);
  static const Color buttonColor = Color(0xFF020202);
  static const Color red = Color(0xC9E43730);
  static const Color filledColor = Color(0xFFe7e7e7);
  static const Color textFiledColor = Color(0xFF979797);
  static const Color yellow = Color(0xffEABB00);
  static const Color green = Color(0xFF31993B);
}
