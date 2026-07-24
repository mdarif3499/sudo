import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/utils/constants/app_colors.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_string.dart';
import '../controller/faq_controller.dart';
import '../data/faq_model.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaqController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: CommonAppBar(title: AppString.faqsTitle.tr),
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
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.faqs.isEmpty) {
              return Center(child: CommonText(text: AppString.noContentAvailable.tr));
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: controller.faqs.length,
              itemBuilder: (context, index) {
                final FaqModel faq = controller.faqs[index];

                return Obx(() {
                  final isExpanded = controller.expandedIndex.value == index;
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCardBg : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : const Color(0xFFE5E7EB), 
                        width: 0.5
                      ),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleExpansion(index),
                          child: Container(
                            height: 57.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CommonText(
                                    text: faq.question ?? "",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: isDark ? Colors.white : AppColors.textPrimary,
                                  ),
                                ),
                                Icon(
                                  isExpanded ? Icons.remove : Icons.add,
                                  size: 20.sp,
                                  color: isDark ? Colors.white70 : const Color(0xFF7C7C7C),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isExpanded)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: 12.w,
                              right: 12.w,
                              bottom: 16.h,
                            ),
                            child: CommonText(
                              text: faq.answer ?? "",
                              fontSize: 13,
                              color: isDark ? Colors.white70 : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                  );
                });
              },
            );
          }),
        ),
      ),
    );
  }
}
