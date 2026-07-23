import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_services.dart';
import '../../../utils/log/app_utils.dart';
import '../data/chat_model.dart';
import '../../../services/socket/socket_service.dart';

class ChatController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isMessageEmpty = true.obs;
  final RxBool isLoading = false.obs;

  String? groupId;
  String? groupName;
  late String currentUserId;

  @override
  void onInit() {
    super.onInit();
    currentUserId = LocalStorage.userId;
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      groupId = args['id'];
      groupName = args['name'];
    } else if (args is String) {
      groupId = args;
    }

    if (groupId != null) {
      fetchMessages();
      _setupSocket();
    }

    messageController.addListener(() {
      isMessageEmpty.value = messageController.text.trim().isEmpty;
    });
  }

  void _setupSocket() {
    SocketService.on("new-message-$groupId", (data) {
      if (data != null) {
        final newMessage = ChatMessage.fromJson(data, currentUserId);
        if (!messages.any((m) => m.id == newMessage.id)) {
          messages.add(newMessage);
          _scrollToBottom();
        }
      }
    });
  }

  Future<void> fetchMessages() async {
    if (groupId == null) return;
    isLoading.value = true;
    messages.clear();
    try {
      final response = await _apiClient.get("${ApiEndPoint.groupMessage}$groupId");
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        messages.value = data.map((json) => ChatMessage.fromJson(json, currentUserId)).toList();
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint("Error fetching messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    if (groupId == null || messageController.text.trim().isEmpty) return;

    final text = messageController.text.trim();
    messageController.clear();

    try {
      final response = await _apiClient.post(
        "${ApiEndPoint.groupMessage}$groupId",
        body: {"text": text},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newMessage = ChatMessage.fromJson(response.data['data'], currentUserId);
        if (!messages.any((m) => m.id == newMessage.id)) {
          messages.add(newMessage);
          _scrollToBottom();
        }
      } else {
        Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      debugPrint("Error sending message: $e");
      Utils.errorSnackBar("Error", "Failed to send message");
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
