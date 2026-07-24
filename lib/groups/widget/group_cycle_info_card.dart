import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_string.dart';
import '../controller/group_details_controller.dart';

class GroupCycleInfoCard extends StatelessWidget {
  const GroupCycleInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupDetailsController controller = Get.find<GroupDetailsController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Obx(() {
      final history = controller.periodHistory.value;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF06D6A0).withValues(alpha: isDark ? 0.1 : 0.07),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFF06D6A0).withValues(alpha: 0.20),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(
              text: AppString.cycleNumber.tr,
              fontSize: 12,
              color: isDark ? Colors.white38 : const Color(0xFF828282),
            ),
            CommonText(
              text: AppString.cycleNum.trParams({'num': '${history?.cycleNumber ?? 1}'}),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF06D6A0),
            ),
          ],
        ),
      );
    });
  }
}
