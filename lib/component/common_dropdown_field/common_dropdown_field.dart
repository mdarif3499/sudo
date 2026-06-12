import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonDropdownField<T> extends StatelessWidget {
  final String? title;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color borderColor;
  final double borderRadius;
  final double paddingHorizontal;
  final double paddingVertical;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? titleColor;

  const CommonDropdownField({
    super.key,
    this.title,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.fillColor = AppColors.white,
    this.borderColor = AppColors.transparent,
    this.borderRadius = 10,
    this.paddingHorizontal = 16,
    this.paddingVertical = 10,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          CommonText(
            text: title!,
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: titleColor ?? AppColors.primaryColor,
          ),
          SizedBox(height: 12.h),
        ],

        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.black),
          dropdownColor: fillColor,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.black,
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w400,
          ),          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: fillColor,
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal.w,
              vertical: paddingVertical.h,
            ),
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
            errorBorder: _buildBorder(),
            hintText: hintText,
            hintStyle: GoogleFonts.roboto(fontSize: 14, color: AppColors.textFiledColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(
        color: borderColor == AppColors.transparent
            ? Colors.grey.withValues(alpha: 0.3)
            : borderColor,
      ),
    );
  }
}