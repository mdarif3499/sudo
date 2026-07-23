import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../controller/privacy_policy_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyPolicyController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Privacy Policy"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.privacyPolicy.value == null || controller.privacyPolicy.value!.content == null) {
          return const Center(child: Text("No content available"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Html(
            data: controller.privacyPolicy.value!.content!,
            style: {
              "body": Style(
                fontSize: FontSize(14.sp),
                color: isDark ? Colors.white : const Color(0xFF575757),
                textAlign: TextAlign.justify,
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
              "h1": Style(
                fontSize: FontSize(22.sp),
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            },
          ),
        );
      }),
    );
  }
}
