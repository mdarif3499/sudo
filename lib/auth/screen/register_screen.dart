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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  CommonText(
                    text: AppString.createAccount.tr,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8.h),
                  CommonText(
                    text: AppString.registerSubtitle.tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : AppColors.textSecondaryColor,
                  ),
                  SizedBox(height: 24.h),

                // Profile Image Picker
                Center(
                  child: GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: Obx(() => Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            color: isDark 
                                ? AppColors.darkCardBg 
                                : AppColors.indicatorActive.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isDark 
                                    ? AppColors.darkCardBorder 
                                    : AppColors.indicatorActive.withValues(alpha: 0.16)),
                            image: controller.profileImagePath.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(
                                        File(controller.profileImagePath.value)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: controller.profileImagePath.isEmpty
                              ? Icon(
                                  Icons.camera_alt_outlined,
                                  size: 32,
                                  color: isDark ? Colors.white38 : AppColors.textSecondaryColor,
                                )
                              : null,
                        )),
                  ),
                ),
                SizedBox(height: 32.h),

                CommonTextField(
                  controller: controller.fullNameController,
                  title: AppString.fullName.tr,
                  hintText: AppString.fullNameHint.tr,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.emailController,
                  title: AppString.emailAddress.tr,
                  hintText: AppString.emailHint.tr,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired.tr;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return AppString.enterValidEmail.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppString.phoneNumber.tr,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: isDark ? Colors.white70 : AppColors.color333333,
                    ),
                    SizedBox(height: 8.h),
                    IntlPhoneField(
                      controller: controller.phoneController,
                      style: GoogleFonts.roboto(
                        fontSize: 14, 
                        color: isDark ? Colors.white : AppColors.black
                      ),
                      dropdownTextStyle: GoogleFonts.roboto(
                        fontSize: 14, 
                        color: isDark ? Colors.white : AppColors.black
                      ),
                      decoration: InputDecoration(
                        hintText: AppString.phoneHint.tr,
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 14,
                          color: isDark ? Colors.white38 : AppColors.textSecondaryColor.withValues(alpha: 0.6),
                        ),
                        filled: true,
                        fillColor: isDark 
                            ? AppColors.darkCardBg 
                            : AppColors.indicatorActive.withValues(alpha: 0.08),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        border: _buildPhoneBorder(context),
                        enabledBorder: _buildPhoneBorder(context),
                        focusedBorder: _buildPhoneBorder(context, isFocused: true),
                        errorBorder: _buildPhoneBorder(context, isError: true),
                        focusedErrorBorder: _buildPhoneBorder(context, isError: true),
                        counterText: '',
                      ),
                      initialCountryCode: 'NG',
                      onCountryChanged: (country) {
                        controller.onCountryChange(country);
                      },
                      validator: (phone) {
                        if (phone == null || phone.number.isEmpty) {
                          return AppString.thisFieldIsRequired.tr;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.addressController,
                  title: AppString.address.tr,
                  hintText: AppString.addressHint.tr,
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.passwordController,
                  title: AppString.password.tr,
                  hintText: AppString.passwordHint.tr,
                  isPassword: true,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired.tr;
                    }
                    if (value.length < 6) {
                      return AppString.enterValidPassword.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.confirmPasswordController,
                  title: AppString.confirmPassword.tr,
                  hintText: AppString.passwordHint.tr,
                  isPassword: true,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.thisFieldIsRequired.tr;
                    }
                    if (value != controller.passwordController.text) {
                      return AppString.thePasswordDoesNotMatch.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                Obx(() => CommonButton(
                      isLoading: controller.isLoading.value,
                      titleText: AppString.next.tr,
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
                          color: isDark ? Colors.white60 : AppColors.textSecondaryColor,
                          fontFamily: 'Roboto',
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: AppString.bySigningUp.tr,
                          ),
                          TextSpan(
                            text: AppString.termsOfService.tr,
                            style: const TextStyle(
                              color: AppColors.color2F80ED,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: AppString.and.tr),
                          TextSpan(
                            text: AppString.privacyPolicy.tr,
                            style: const TextStyle(
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
                      text: AppString.alreadyHaveAccount.tr,
                      fontSize: 14,
                      color: isDark ? Colors.white60 : AppColors.textSecondaryColor,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.login),
                      child: CommonText(
                        text: AppString.signIn.tr,
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
    ));
  }

  OutlineInputBorder _buildPhoneBorder(BuildContext context, {bool isError = false, bool isFocused = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: BorderSide(
        color: isError
            ? AppColors.red
            : (isFocused
                ? AppColors.indicatorActive
                : (isDark
                    ? AppColors.darkCardBorder
                    : AppColors.indicatorActive.withValues(alpha: 0.16))),
        width: 1,
      ),
    );
  }
}
