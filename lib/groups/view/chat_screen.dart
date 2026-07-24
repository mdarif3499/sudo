import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../component/image/common_image.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/chat_controller.dart';
import '../data/chat_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
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
          child: Column(
            children: [
              _buildAppBar(controller),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.messages.isEmpty) {
                      return Center(
                        child: CommonText(
                          text: AppString.noMessagesYet.tr,
                          fontSize: 14.sp,
                          color: isDark ? Colors.white38 : Colors.grey,
                        ),
                      );
                    }

                    return ListView.separated(
                      controller: controller.scrollController,
                      reverse: false,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      itemCount: controller.messages.length,
                      separatorBuilder: (context, index) => SizedBox(height: 20.h),
                      itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      if (message.isMe) {
                        return _buildSenderMessage(message);
                      } else {
                        return _buildReceiverMessage(message);
                      }
                    },
                  );
                }),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(ChatController controller) {
    final isDark = Get.isDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        border: Border(
          bottom: BorderSide(color: isDark ? Colors.white10 : const Color(0xFFF2F2F7)),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isDark ? Colors.white24 : const Color(0xFFE0E0E0)),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: isDark ? Colors.white : AppColors.black,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: CommonText(
              text: controller.groupName ?? AppString.groupChat.tr,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiverMessage(ChatMessage message) {
    final isDark = Get.isDarkMode;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 36.r,
          width: 36.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: (message.senderImage == null || message.senderImage!.isEmpty) 
                ? AppColors.primaryGradient 
                : null,
          ),
          child: (message.senderImage != null && message.senderImage!.isNotEmpty)
              ? CommonImage(
                  imageSrc: message.senderImage!,
                  borderRadius: 18,
                  height: 36,
                  width: 36,
                  fill: BoxFit.cover,
                )
              : Center(
                  child: CommonText(
                    text: (message.senderName ?? "U").substring(0, 1).toUpperCase(),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: message.senderName ?? "Unknown",
                fontSize: 12.sp,
                color: isDark ? Colors.white38 : Colors.grey,
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBg : Colors.white,
                  border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFF2F2F7)),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                    topLeft: Radius.circular(4.r),
                  ),
                ),
                child: CommonText(
                  text: message.message,
                  fontSize: 14.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              CommonText(
                text: message.time,
                fontSize: 10.sp,
                color: isDark ? Colors.white38 : Colors.grey,
              ),
            ],
          ),
        ),
        SizedBox(width: 40.w), // Space on the right for balance
      ],
    );
  }

  Widget _buildSenderMessage(ChatMessage message) {
    final isDark = Get.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: CommonText(
            text: message.message,
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        CommonText(
          text: message.time,
          fontSize: 10.sp,
          color: isDark ? Colors.white38 : Colors.grey,
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    final controller = Get.find<ChatController>();
    final isDark = Get.isDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        border: Border(
          top: BorderSide(color: isDark ? Colors.white10 : const Color(0xFFF2F2F7)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: AppString.typeMessageHint.tr,
                hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.grey, fontSize: 14.sp),
                filled: true,
                fillColor: isDark ? AppColors.darkCardBg : const Color(0xFFF1F8FF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: isDark ? const BorderSide(color: AppColors.darkCardBorder) : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: isDark ? const BorderSide(color: AppColors.darkCardBorder) : BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Obx(
            () => GestureDetector(
              onTap: controller.isMessageEmpty.value
                  ? null
                  : () => controller.sendMessage(),
              child: Container(
                height: 54.r,
                width: 54.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: controller.isMessageEmpty.value
                        ? [const Color(0xFF8EDAF9), const Color(0xFF919AF3)]
                        : [const Color(0xFF00ADEF), const Color(0xFF3B44D1)],
                  ),
                ),
                child: Center(
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 26.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
