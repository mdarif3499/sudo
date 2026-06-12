import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leadingWidth: 70.w,
      leading: showBackButton
          ? Padding(
        padding: EdgeInsets.only(left: 24.w),
        child: Center(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 4,
              child: SizedBox(
                height: 40.h,
                width: 40.h,
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      )
          : null,
      title: title != null
          ? CommonText(
        text: title!,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}