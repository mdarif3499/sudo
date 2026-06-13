import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text/common_text.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Screen background is now plain white
      appBar: const CommonAppBar(title: "Choose your plan"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            CommonText(
              text: "You are currently using the free plan. Upgrade anytime to unlock premium smart navigation features.",
              fontSize: 13,
              color: const Color(0xFF475569),
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 32.h),
            
            _buildPlanCard(
              title: "Current Plan",
              subtitle: "Free",
              price: "\$0",
              features: ["Pot size: up to \$1000", "Up to 5 members", "1 active circle"],
              isActive: true,
              icon: Icons.bolt,
              iconColor: const Color(0xFF0EA5E9),
            ),
            
            SizedBox(height: 24.h),
            
            _buildPlanCard(
              title: "Plus",
              subtitle: "/month",
              price: "\$9.99",
              features: ["Pot size: up to \$10,000", "Up to 25 members", "5 active circles"],
              isPopular: true,
              icon: Icons.workspace_premium_outlined,
              iconColor: const Color(0xFF0EA5E9),
              showButton: true,
            ),
            
            SizedBox(height: 24.h),
            
            _buildPlanCard(
              title: "Family",
              subtitle: "/month",
              price: "\$19.99",
              features: ["Pot size: up to \$50,000", "Up to 50 members", "unlimited circles"],
              icon: Icons.workspace_premium_outlined,
              iconColor: const Color(0xFF0EA5E9),
              showButton: true,
            ),
            
            SizedBox(height: 24.h),
            
            _buildPlanCard(
              title: "Community",
              subtitle: "/month",
              price: "\$39.99",
              features: ["Pot size: up to \$250,000", "Up to 200 members", "Advanced reporting and governance tools"],
              icon: Icons.workspace_premium_outlined,
              iconColor: const Color(0xFF0EA5E9),
              showButton: true,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required List<String> features,
    bool isActive = false,
    bool isPopular = false,
    bool showButton = false,
    required IconData icon,
    required Color iconColor,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFE9E8FD), // Left side
                Color(0xFFDAF6FF), // Right side
              ],
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: isPopular ? const Color(0xFF4A7FE0) : Colors.white.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE9E8FD).withValues(alpha: 0.8),
                blurRadius: 20,
                offset: const Offset(-8, 0),
              ),
              BoxShadow(
                color: const Color(0xFFDAF6FF).withValues(alpha: 0.8),
                blurRadius: 20,
                offset: const Offset(8, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: iconColor, size: 24.sp),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: title,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                          if (subtitle == "Free")
                            CommonText(
                              text: subtitle,
                              fontSize: 13,
                              color: const Color(0xFF64748B),
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (isActive)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: CommonText(
                        text: "Active",
                        fontSize: 12,
                        color: const Color(0xFF166534),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText(
                    text: price,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                  if (subtitle != "Free")
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: CommonText(
                        text: subtitle,
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16.h),
              ...features.map((feature) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Icon(Icons.check_rounded, color: const Color(0xFF0EA5E9), size: 18.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CommonText(
                        text: feature,
                        fontSize: 13,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              )),
              if (showButton) ...[
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00A3FF), Color(0xFF3D5AFE)],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3D5AFE).withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: CommonText(
                      text: "Upgrade Now",
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (isPopular)
          Positioned(
            top: -12.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00A3FF), Color(0xFF3D5AFE)],
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: CommonText(
                  text: "Most Popular",
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
