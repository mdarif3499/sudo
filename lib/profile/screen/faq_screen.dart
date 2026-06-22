import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/utils/constants/app_colors.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text/common_text.dart';
import '../controller/faq_controller.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaqController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "FAQ's"),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        itemCount: controller.faqs.length,
        itemBuilder: (context, index) {
          final faq = controller.faqs[index];
          return Obx(() {
            final isExpanded = controller.expandedIndex.value == index;

            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFf4f4fe), Color(0xFFf4fcfe)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 0.5),
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
                              text: faq['question']!,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Icon(
                            isExpanded ? Icons.remove : Icons.add,
                            size: 20.sp,
                            color: Color(0xFF7C7C7C),
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
                        text: faq['answer']!,
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
