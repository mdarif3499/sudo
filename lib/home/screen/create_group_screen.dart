import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../component/button/common_button.dart';
import '../controller/create_group_controller.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateGroupController controller = Get.put(CreateGroupController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
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
        child: Column(
          children: [
            _buildAppBar(context, isDark),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: GetBuilder<CreateGroupController>(
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Center(
                          child: CommonText(
                            text: AppString.createGroupSubtitle.tr,
                            fontSize: 14.sp,
                            color: isDark ? Colors.white60 : Colors.grey,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Group Name
                        _buildLabel(context, AppString.groupNameLabel.tr),
                        CommonTextField(
                          controller: controller.nameController,
                          hintText: AppString.groupNameHint.tr,
                          prefixIcon: Icon(Icons.people_outline, size: 20.sp, color: isDark ? Colors.white38 : Colors.grey),
                          borderRadius: 24,
                        ),
                        SizedBox(height: 16.h),

                        // Target Pool Amount
                        _buildLabel(context, AppString.targetPoolAmountLabel.tr),
                        CommonTextField(
                          controller: controller.targetAmountController,
                          hintText: "100000",
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: CommonText(text: "\$", fontSize: 16.sp, color: isDark ? Colors.white38 : Colors.grey),
                          ),
                          borderRadius: 24,
                          onChanged: (v) => controller.validateAmounts(),
                        ),
                        SizedBox(height: 16.h),

                        _buildLabel(context, AppString.contributionAmountPerMember.tr),
                        CommonTextField(
                          controller: controller.contributionController,
                          hintText: "200",
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: CommonText(text: "\$", fontSize: 16.sp, color: isDark ? Colors.white38 : Colors.grey),
                          ),
                          borderRadius: 24,
                          errorText: controller.contributionError,
                          onChanged: (v) => controller.validateAmounts(),
                        ),
                        SizedBox(height: 16.h),

                        // Total Cycles
                        _buildLabel(context, AppString.totalCyclesInput.tr),
                        CommonTextField(
                          controller: controller.totalCyclesController,
                          hintText: "e.g., 20",
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(Icons.loop, size: 20.sp, color: isDark ? Colors.white38 : Colors.grey),
                          borderRadius: 24,
                        ),
                        SizedBox(height: 16.h),

                        _buildLabel(context, AppString.paymentFrequency.tr),
                        Obx(() => Row(
                          children: [
                            Expanded(child: _buildFrequencyItem(context, controller, AppString.weekly.tr, Icons.access_time)),
                            SizedBox(width: 12.w),
                            Expanded(child: _buildFrequencyItem(context, controller, AppString.monthly.tr, Icons.access_time)),
                            SizedBox(width: 12.w),
                            Expanded(child: _buildFrequencyItem(context, controller, AppString.quarterly.tr, Icons.access_time)),
                          ],
                        )),
                        
                        Obx(() {
                          final frequency = controller.selectedFrequency.value;
                          List<String> options = [];
                          
                          if (frequency == AppString.quarterly.tr) {
                            options = ["2 Months", "3 Months", "4 Months", "5 Months","6 Months"];
                          }

                          if (options.isNotEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: 12.h),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: options.map((opt) => _buildRadioButton(context, controller, opt)).toList(),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        SizedBox(height: 16.h),

                        // Start Date
                        _buildLabel(context, AppString.startDate.tr),
                        CommonTextField(
                          controller: controller.startDateController,
                          hintText: "MM/DD/YYYY",
                          prefixIcon: Icon(Icons.calendar_today_outlined, size: 20.sp, color: isDark ? Colors.white38 : Colors.grey),
                          borderRadius: 24,
                          readOnly: true,
                          onTap: () => controller.selectDate(context),
                        ),
                        SizedBox(height: 16.h),

                        // Visibility
                        _buildLabel(context, AppString.visibilityLabel.tr),
                        Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Obx(() => Row(
                            children: [
                              Expanded(child: _buildVisibilityItem(context, controller, "Private")),
                              Expanded(child: _buildVisibilityItem(context, controller, "Public")),
                            ],
                          )),
                        ),
                        SizedBox(height: 24.h),

                        // Action Buttons
                        Obx(() => CommonButton(
                          titleText: AppString.createGroup.tr,
                          isLoading: controller.isLoading.value,
                          gradient: AppColors.primaryGradient,
                          buttonRadius: 24,
                          onTap: () => controller.createGroup(),
                        )),
                        SizedBox(height: 12.h),
                        Center(
                          child: TextButton(
                            onPressed: () => Get.back(),
                            child: CommonText(
                              text: AppString.cancel.tr,
                              fontSize: 16.sp,
                              color: isDark ? Colors.white38 : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isDark ? Colors.white12 : Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black, size: 20.sp),
          ),
        ),
      ),
      title: CommonText(
        text: AppString.createGroupTitle.tr,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: false,
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CommonText(
        text: text,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
    );
  }

  Widget _buildFrequencyItem(BuildContext context, CreateGroupController controller, String label, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isSelected = controller.selectedFrequency.value == label;
    return GestureDetector(
      onTap: () => controller.setFrequency(label),
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: isSelected ? null : (isDark ? AppColors.darkCardBg : Colors.white),
          gradient: isSelected ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected ? null : Border.all(color: isDark ? AppColors.darkCardBorder : Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.white : (isDark ? Colors.white38 : Colors.grey), size: 24.sp),
            SizedBox(height: 4.h),
            CommonText(
              text: label,
              fontSize: 12.sp,
              color: isSelected ? Colors.white : (isDark ? Colors.white38 : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(BuildContext context, CreateGroupController controller, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isSelected = controller.selectedDuration.value == value;
    return GestureDetector(
      onTap: () => controller.setDuration(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: controller.selectedDuration.value,
            onChanged: (val) {
              if (val != null) controller.setDuration(val);
            },
            activeColor: Colors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          CommonText(
            text: value,
            fontSize: 12.sp,
            color: isSelected ? (isDark ? Colors.white : Colors.black) : (isDark ? Colors.white38 : Colors.grey),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget _buildVisibilityItem(BuildContext context, CreateGroupController controller, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isSelected = controller.selectedVisibility.value == label;
    return GestureDetector(
      onTap: () => controller.setVisibility(label),
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(24.r),
        ),
        alignment: Alignment.center,
        child: CommonText(
          text: label,
          fontSize: 14.sp,
          color: isSelected ? Colors.white : (isDark ? Colors.white38 : Colors.grey),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
