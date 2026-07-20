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
    this.hintTextColor,
    this.labelTextColor,
    this.textColor,
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
    this.errorText,
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
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            CommonText(
              text: title ?? "",
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 14,
              color: titleColor ?? (isDark ? Colors.white70 : AppColors.color333333),
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
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: textColor ?? theme.textTheme.bodyLarge?.color,
            ),
            onFieldSubmitted: onSubmitted,
            onTap: onTap,
            validator: validator,
            maxLines: isPassword ? 1 : maxLines,
            decoration: InputDecoration(
              errorText: errorText,
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
              fillColor: fillColor ??
                  (isDark
                      ? AppColors.darkCardBg
                      : AppColors.indicatorActive.withValues(alpha: 0.08)),
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal.w,
                vertical: paddingVertical.h,
              ),
              border: _buildBorder(context),
              enabledBorder: _buildBorder(context),
              focusedBorder: _buildBorder(context, isFocused: true),
              disabledBorder: _buildBorder(context),
              errorBorder: _buildBorder(context, isError: true),
              hintText: hintText,
              labelText: labelText,
              hintStyle: GoogleFonts.roboto(
                fontSize: 14,
                color: hintTextColor ?? (isDark ? Colors.white38 : AppColors.textSecondaryColor.withValues(alpha: 0.6)),
              ),
              labelStyle: GoogleFonts.roboto(
                fontSize: 14,
                color: labelTextColor ?? (isDark ? Colors.white70 : AppColors.textFiledColor),
              ),
              prefix: prefixText != null
                  ? CommonText(
                      text: prefixText ?? '',
                      fontWeight: FontWeight.w400,
                    )
                  : null,
              suffixIcon: isPassword ? _buildPasswordSuffixIcon(context) : suffixIcon,
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildBorder(BuildContext context, {bool isError = false, bool isFocused = false}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(
        color: isError
            ? AppColors.red
            : (isFocused
                ? AppColors.indicatorActive
                : (borderColor ??
                    (isDark
                        ? AppColors.darkCardBorder
                        : AppColors.indicatorActive.withValues(alpha: 0.16)))),
        width: 1,
      ),
    );
  }

  Widget _buildPasswordSuffixIcon(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            color: isDark ? Colors.white38 : AppColors.textSecondaryColor,
          ),
        ),
      ),
    );
  }

  void toggle() {
    obscureText.value = !obscureText.value;
  }
}
