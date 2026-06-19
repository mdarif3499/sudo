import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../data/chat_model.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isMessageEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialMessages();
    messageController.addListener(() {
      isMessageEmpty.value = messageController.text.trim().isEmpty;
    });
  }

  void _loadInitialMessages() {
    messages.addAll([
      ChatMessage(
        senderName: "Jane Smith",
        message: "Just made this month's contribution!",
        time: "10:30 AM",
        isMe: false,
      ),
      ChatMessage(
        senderName: "Me",
        message: "Great! Thanks Jane",
        time: "10:32 AM",
        isMe: true,
      ),
      ChatMessage(
        senderName: "Mike Johnson",
        message: "I'll send mine by tomorrow",
        time: "11:15 AM",
        isMe: false,
      ),
      ChatMessage(
        senderName: "Me",
        message: "No worries Mike, thanks for the update!",
        time: "11:16 AM",
        isMe: true,
      ),
    ]);
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      final newMessage = ChatMessage(
        senderName: "Me",
        message: messageController.text.trim(),
        time: DateFormat('hh:mm a').format(DateTime.now()),
        isMe: true,
      );
      messages.add(newMessage);
      messageController.clear();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
