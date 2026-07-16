import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../config/route/app_routes.dart';
import '../../../utils/constants/app_string.dart';
import '../controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                CommonText(
                  text: "Create Account",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryColor,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: "Join thousands saving together",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(height: 24.h),

                // Profile Image Picker (Optional)
                Center(
                  child: GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: Obx(() => Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            color: AppColors.indicatorActive.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.indicatorActive
                                    .withValues(alpha: 0.16)),
                            image: controller.profileImagePath.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(
                                        File(controller.profileImagePath.value)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: controller.profileImagePath.isEmpty
                              ? const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 32,
                                  color: AppColors.textSecondaryColor,
                                )
                              : null,
                        )),
                  ),
                ),
                SizedBox(height: 32.h),

                CommonTextField(
                  controller: controller.fullNameController,
                  title: "Full Name",
                  hintText: "John Doe",
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    size: 20,
                    color: AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.emailController,
                  title: "Email Address",
                  hintText: "john@example.com",
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: AppColors.textSecondaryColor,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return AppString.enterValidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                
                // Professional Phone Number Field with Country Code
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Phone Number",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.color333333,
                    ),
                    SizedBox(height: 8.h),
                    IntlPhoneField(
                      controller: controller.phoneController,
                      style: GoogleFonts.roboto(fontSize: 14, color: AppColors.black),
                      dropdownTextStyle: GoogleFonts.roboto(fontSize: 14, color: AppColors.black),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor.withValues(alpha: 0.6),
                        ),
                        filled: true,
                        fillColor: AppColors.indicatorActive.withValues(alpha: 0.08),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        border: _buildPhoneBorder(),
                        enabledBorder: _buildPhoneBorder(),
                        focusedBorder: _buildPhoneBorder(),
                        errorBorder: _buildPhoneBorder(isError: true),
                        focusedErrorBorder: _buildPhoneBorder(isError: true),
                        counterText: '',
                      ),
                      initialCountryCode: 'NG',
                      onCountryChanged: (country) {
                        controller.onCountryChange(country);
                      },
                      validator: (phone) {
                        if (phone == null || phone.number.isEmpty) {
                          return AppString.thisFieldIsRequired;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.addressController,
                  title: "Address",
                  hintText: "Enter your address",
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.passwordController,
                  title: "Password",
                  hintText: "Min. 6 characters",
                  isPassword: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired;
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.confirmPasswordController,
                  title: "Confirm Password",
                  hintText: "Min. 6 characters",
                  isPassword: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired;
                    }
                    if (value != controller.passwordController.text) {
                      return AppString.thePasswordDoesNotMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                Obx(() => CommonButton(
                      isLoading: controller.isLoading.value,
                      titleText: "Next",
                      gradient: AppColors.primaryGradient,
                      onTap: () => controller.signUp(),
                    )),
                SizedBox(height: 24.h),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondaryColor,
                          fontFamily: 'Roboto',
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: "By signing up, you agree to our ",
                          ),
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: AppColors.color2F80ED,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: AppColors.color2F80ED,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: "Already have an account? ",
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.login),
                      child: CommonText(
                        text: "Sign In",
                        fontSize: 14,
                        color: AppColors.color2F80ED,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildPhoneBorder({bool isError = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: BorderSide(
        color: isError
            ? AppColors.red
            : AppColors.indicatorActive.withValues(alpha: 0.16),
        width: 1,
      ),
    );
  }
}
