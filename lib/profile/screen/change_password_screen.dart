import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text_field/common_text_field.dart';
import '../../utils/constants/app_colors.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Change Password"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              
              // Old Password Field
              CommonTextField(
                controller: controller.oldPasswordController,
                title: "Old Password",
                hintText: "Min. 8 characters",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: Color(0xFF94A3B8)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter old password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              
              // New Password Field
              CommonTextField(
                controller: controller.newPasswordController,
                title: "New Password",
                hintText: "Min. 8 characters",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: Color(0xFF94A3B8)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter new password";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              
              // Confirm Password Field
              CommonTextField(
                controller: controller.confirmPasswordController,
                title: "Confirm Password",
                hintText: "Re-enter password",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: Color(0xFF94A3B8)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password";
                  }
                  if (value != controller.newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 40.h),
              
              // Save Changes Button (Stripe Blue Gradient)
              CommonButton(
                titleText: "Save All Changes",
                gradient: const LinearGradient(
                  colors: [Color(0xFF00A3FF), Color(0xFF3D5AFE)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                onTap: () => controller.changePassword(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
