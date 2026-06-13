import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.validator,
    this.prefixText,
    this.paddingHorizontal = 12,
    this.paddingVertical = 12,
    this.borderRadius = 32,
    this.inputFormatters,
    this.fillColor,
    this.hintTextColor = AppColors.textSecondaryColor,
    this.labelTextColor = AppColors.textFiledColor,
    this.textColor = AppColors.black,
    this.borderColor,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.isDense,
    this.suffixIcon,
    this.maxLines,
    this.titleColor,
    this.fontSize = 14,
    this.fontWeight,
    this.title,
    this.readOnly,
  });

  final String? hintText;
  final String? title;
  final Color? titleColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? borderColor;
  final double paddingHorizontal;
  final double paddingVertical;
  final int? maxLines;
  final double borderRadius;
  final int? maxLength;
  final bool isPassword;
  final bool? isDense;
  RxBool obscureText = false.obs;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            CommonText(
              text: title ?? "",
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 14,
              color: titleColor ?? AppColors.color333333,
            ),
            SizedBox(height: 8.h),
          ],
          TextFormField(
            readOnly: readOnly ?? false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            controller: controller,
            obscureText: isPassword ? !obscureText.value : obscureText.value,
            textInputAction: textInputAction,
            maxLength: maxLength,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            style: GoogleFonts.roboto(fontSize: 14, color: textColor),
            onFieldSubmitted: onSubmitted,
            onTap: onTap,
            validator: validator,
            maxLines: isPassword ? 1 : maxLines,
            decoration: InputDecoration(
              errorMaxLines: 2,
              isDense: isDense ?? true,
              filled: true,
              prefixIconConstraints: BoxConstraints(
                minWidth: 40.w,
                maxHeight: 48.h,
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 4.w),
                      child: prefixIcon,
                    )
                  : null,
              fillColor:
                  fillColor ??
                  AppColors.indicatorActive.withValues(alpha: 0.08),
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal.w,
                vertical: paddingVertical.h,
              ),
              border: _buildBorder(),
              enabledBorder: _buildBorder(),
              focusedBorder: _buildBorder(),
              disabledBorder: _buildBorder(),
              errorBorder: _buildBorder(isError: true),
              hintText: hintText,
              labelText: labelText,
              hintStyle: GoogleFonts.roboto(
                fontSize: 14,
                color: hintTextColor?.withValues(alpha: 0.6),
              ),
              labelStyle: GoogleFonts.roboto(
                fontSize: 14,
                color: labelTextColor,
              ),
              prefix: prefixText != null
                  ? CommonText(
                      text: prefixText ?? '',
                      fontWeight: FontWeight.w400,
                    )
                  : null,
              suffixIcon: isPassword ? _buildPasswordSuffixIcon() : suffixIcon,
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildBorder({bool isError = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(
        color: isError
            ? AppColors.red
            : (borderColor ??
                  AppColors.indicatorActive.withValues(alpha: 0.16)),
        width: 1,
      ),
    );
  }

  Widget _buildPasswordSuffixIcon() {
    return GestureDetector(
      onTap: toggle,
      child: Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: Obx(
          () => Icon(
            obscureText.value
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20.sp,
            color: AppColors.textSecondaryColor,
          ),
        ),
      ),
    );
  }

  void toggle() {
    obscureText.value = !obscureText.value;
  }
}
