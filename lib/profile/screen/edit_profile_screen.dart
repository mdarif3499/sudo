import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../component/button/common_button.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/image/common_image.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../utils/constants/app_colors.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(title: "Edit Profile"),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: CommonText(
                    text: "Search your saving groups",
                    fontSize: 14,
                    color: AppColors.textSecondaryColor7C7C7C,
                  ),
                ),
                SizedBox(height: 24.h),
                // Profile Image Selection
                _buildProfileImagePicker(controller),
                SizedBox(height: 32.h),
                // Form Fields
                CommonTextField(
                  controller: controller.fullNameController,
                  title: "Full Name",
                  hintText: "John Doe",
                  prefixIcon: const Icon(Icons.person_outline,
                      size: 20, color: AppColors.textSecondaryColor),
                ),
                SizedBox(height: 16.h),
                CommonTextField(
                  controller: controller.emailController,
                  title: "Email Address",
                  hintText: "john@example.com",
                  readOnly: true,
                  prefixIcon: const Icon(Icons.email_outlined,
                      size: 20, color: AppColors.textSecondaryColor),
                  keyboardType: TextInputType.emailAddress,
                ),
                CommonTextField(
                  controller: controller.phoneController,
                  title: "Phone Number",
                  hintText: "+1 (555) 000-0000",
                  prefixIcon: const Icon(Icons.phone_outlined,
                      size: 20, color: AppColors.textSecondaryColor),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.h),
                CommonTextField(
                  controller: controller.addressController,
                  title: "Address",
                  hintText: "123 Main St, New York, NY 10001",
                  prefixIcon: const Icon(Icons.location_on_outlined,
                      size: 20, color: AppColors.textSecondaryColor),
                ),
                SizedBox(height: 40.h),
                // Buttons
                Obx(() => CommonButton(
                  titleText: "Save Changes",
                  isLoading: controller.isLoading.value,
                  gradient: AppColors.primaryGradient,
                  onTap: () => controller.saveChanges(),
                )),
                SizedBox(height: 12.h),
                CommonButton(
                  titleText: "Cancel",
                  buttonColor: Colors.transparent,
                  titleColor: AppColors.textSecondaryColor,
                  borderColor: Colors.grey.withValues(alpha: 0.3),
                  onTap: () => Get.back(),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker(EditProfileController controller) {
    return GestureDetector(
      onTap: () => _showImageSourceSheet(controller),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Obx(() => Container(
                  height: 100.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: (controller.selectedImagePath.isEmpty && controller.imageUrl == null) ? AppColors.primaryGradient : null,
                    image: controller.selectedImagePath.isNotEmpty
                        ? DecorationImage(
                            image: FileImage(File(controller.selectedImagePath.value)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: controller.selectedImagePath.isEmpty
                      ? controller.imageUrl != null
                          ? CommonImage(
                              imageSrc: controller.imageUrl!,
                              borderRadius: 50,
                              height: 100,
                              width: 100,
                              fill: BoxFit.cover,
                            )
                          : Center(
                              child: CommonText(
                                text: controller.fullNameController.text.isNotEmpty 
                                    ? controller.fullNameController.text.substring(0, 1).toUpperCase()
                                    : "U",
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                      : null,
                )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 32.h,
                    width: 32.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A7FE0),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            CommonText(
              text: "Tap to change photo",
              fontSize: 12,
              color: AppColors.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceSheet(EditProfileController controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonText(
              text: "Choose Profile Photo",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.camera);
                  },
                ),
                _buildSourceOption(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.indicatorActive.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.indicatorActive, size: 30),
          ),
          SizedBox(height: 8.h),
          CommonText(text: label, fontSize: 14),
        ],
      ),
    );
  }
}
