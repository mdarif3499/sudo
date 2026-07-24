import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../../services/localization/language_controller.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final LanguageController controller = Get.find<LanguageController>();
  late String tempSelectedLanguage;
  late String tempLangCode;
  late String tempCountryCode;

  @override
  void initState() {
    super.initState();
    tempSelectedLanguage = controller.selectedLanguage.value;
    if (tempSelectedLanguage == 'Spanish') {
      tempLangCode = 'es';
      tempCountryCode = 'ES';
    } else {
      tempLangCode = 'en';
      tempCountryCode = 'US';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: CommonAppBar(title: AppString.language.tr),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: isDark ? null : const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFFFDF8),
              Color(0xFFF2FDFB),
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.2, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                _buildLanguageOption(
                  title: AppString.english.tr,
                  isSelected: tempSelectedLanguage == 'English',
                  onTap: () {
                    setState(() {
                      tempSelectedLanguage = 'English';
                      tempLangCode = 'en';
                      tempCountryCode = 'US';
                    });
                  },
                ),
                SizedBox(height: 16.h),
                _buildLanguageOption(
                  title: AppString.spanish.tr,
                  isSelected: tempSelectedLanguage == 'Spanish',
                  onTap: () {
                    setState(() {
                      tempSelectedLanguage = 'Spanish';
                      tempLangCode = 'es';
                      tempCountryCode = 'ES';
                    });
                  },
                ),
                const Spacer(),
                CommonButton(
                  titleText: AppString.confirm.tr,
                  onTap: () {
                    controller.changeLanguage(tempSelectedLanguage, tempLangCode, tempCountryCode);
                    Get.back();
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBg : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : (isDark ? AppColors.darkCardBorder : Colors.grey.withValues(alpha: 0.1)),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: title,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primaryColor)
            else
              Icon(Icons.circle_outlined, color: Colors.grey.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}
