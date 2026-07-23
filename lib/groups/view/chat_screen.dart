import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../component/image/common_image.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../controller/chat_controller.dart';
import '../data/chat_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                        text: "No messages yet. Say hi!",
                        fontSize: 14.sp,
                        color: Colors.grey,
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
    );
  }

  Widget _buildAppBar(ChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF2F2F7)),
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
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: CommonText(
              text: controller.groupName ?? "Group Chat",
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiverMessage(ChatMessage message) {
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
                color: Colors.grey,
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFF2F2F7)),
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
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              CommonText(
                text: message.time,
                fontSize: 10.sp,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        SizedBox(width: 40.w), // Space on the right for balance
      ],
    );
  }

  Widget _buildSenderMessage(ChatMessage message) {
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
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    final controller = Get.find<ChatController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF2F2F7)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                filled: true,
                fillColor: const Color(0xFFF1F8FF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
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
