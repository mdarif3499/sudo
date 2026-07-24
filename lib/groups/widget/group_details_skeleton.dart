import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../component/other_widgets/common_skeleton.dart';

class GroupDetailsSkeleton extends StatelessWidget {
  const GroupDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              CommonSkeleton(height: 40.r, width: 40.r, borderRadius: 20),
              SizedBox(width: 15.w),
              CommonSkeleton(height: 24.h, width: 150.w),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                CommonSkeleton(height: 200.h, width: double.infinity, borderRadius: 24),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(child: CommonSkeleton(height: 52.h, width: double.infinity, borderRadius: 14)),
                    SizedBox(width: 15.w),
                    Expanded(child: CommonSkeleton(height: 52.h, width: double.infinity, borderRadius: 14)),
                  ],
                ),
                SizedBox(height: 15.h),
                CommonSkeleton(height: 60.h, width: double.infinity, borderRadius: 8),
                SizedBox(height: 25.h),
                CommonSkeleton(height: 20.h, width: 100.w),
                SizedBox(height: 12.h),
                CommonSkeleton(height: 150.h, width: double.infinity, borderRadius: 20),
                SizedBox(height: 20.h),
                CommonSkeleton(height: 20.h, width: 150.w),
                SizedBox(height: 12.h),
                CommonSkeleton(height: 80.h, width: double.infinity, borderRadius: 16),
                SizedBox(height: 20.h),
                CommonSkeleton(height: 120.h, width: double.infinity, borderRadius: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
