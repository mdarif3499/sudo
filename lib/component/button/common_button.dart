import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color? buttonColor;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  final bool showIcon;
  final String? iconPath;
  final Color? iconColor;

  final Widget? prefixIcon;

  const CommonButton({
    super.key,
    this.onTap,
    required this.titleText,
    this.titleColor = Colors.white,
    this.buttonColor,
    this.gradient,
    this.titleSize = 16,
    this.buttonRadius = 32,
    this.titleWeight = FontWeight.w600,
    this.buttonHeight = 48,
    this.borderWidth = 1,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.borderColor,
    this.padding,
    this.showIcon = false,
    this.iconPath,
    this.iconColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth?.w,
      height: buttonHeight.h,
      decoration: BoxDecoration(
        color: gradient == null ? (buttonColor ?? Colors.blue) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(buttonRadius.r),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (isLoading || onTap == null) ? null : onTap,
          borderRadius: BorderRadius.circular(buttonRadius.r),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Center(
              child: isLoading
                  ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: 8.w),
                  ],

                  Text(
                    titleText,
                    style: TextStyle(color: titleColor, fontSize: titleSize.sp, fontWeight: titleWeight),
                  ),

                  if (showIcon) ...[
                    SizedBox(width: 8.w),
                    Image.asset(
                      iconPath ?? 'assets/icons/arrow_right.png',
                      height: 14.h,
                      width: 14.w,
                      color: iconColor ?? Colors.white,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}