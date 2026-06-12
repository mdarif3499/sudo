import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_colors.dart';
import '../../component/text/common_text.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? trailingText;
  final Color? trailingTextColor;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBgColor;

  const ProfileMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.trailingText,
    this.trailingTextColor,
    this.trailing,
    required this.onTap,
    required this.iconColor,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        iconPath,
        color: iconColor,
        height: 40.sp,
        width: 40.sp,
      ),
      title: CommonText(
        text: title,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryColor,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color:
                    trailingTextColor?.withValues(alpha: 0.1) ??
                    Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: CommonText(
                text: trailingText!,
                fontSize: 10,
                color: trailingTextColor ?? AppColors.textSecondaryColor,
              ),
            ),
          trailing ??
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
        ],
      ),
    );
  }
}
