import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_services.dart';
import '../../../utils/log/app_utils.dart';
import '../../utils/constants/app_string.dart';
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

  void _onSocketConnect(dynamic _) {
    debugPrint("✅ Chat Socket: Reconnected, joining room $groupId");
    SocketService.emit("join-group-chat", groupId);
  }

  void _setupSocket() {
    if (groupId == null) return;
    
    debugPrint("💬 Chat: Setting up socket for group $groupId");
    
    // সকেট কানেক্টেড থাকুক বা না থাকুক, আমরা Listen অন করে রাখছি
    SocketService.on("new-group-message", _handleNewMessage);

    // সকেট কানেক্ট হলে যেন অটোমেটিক গ্রুপে জয়েন করে (রিয়েল-টাইম নিশ্চিত করতে)
    SocketService.on("connect", _onSocketConnect);

    // প্রথমবার স্ক্রিনে আসলে জয়েন করার চেষ্টা করবে
    if (SocketService.isConnected) {
      SocketService.emit("join-group-chat", groupId);
    } else {
      SocketService.connect();
    }
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
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      debugPrint("Error sending message: $e");
      Utils.errorSnackBar(AppString.someThingWrong.tr, "Failed to send message");
    }
  }

  void _handleNewMessage(dynamic data) {
    debugPrint("📩 Chat: Received new message from socket: $data");
    if (data != null) {
      try {
        final newMessage = ChatMessage.fromJson(data, currentUserId);
        
        // Filter by groupId if available in the payload
        final incomingGroupId = newMessage.groupId;
        if (incomingGroupId != null && incomingGroupId != groupId) {
          debugPrint("ℹ️ Chat: Message belongs to another group ($incomingGroupId), current is $groupId. Skipping.");
          return;
        }
        
        if (!messages.any((m) => m.id == newMessage.id)) {
          messages.add(newMessage);
          _scrollToBottom();
          debugPrint("✅ Chat: Message added to list");
        } else {
          debugPrint("ℹ️ Chat: Message already exists, skipping");
        }
      } catch (e) {
        debugPrint("❌ Chat: Error parsing socket message: $e");
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    debugPrint("🔌 Chat: Leaving group $groupId and cleaning up socket");
    SocketService.off("connect", _onSocketConnect);
    if (groupId != null) {
      SocketService.emit("leave-group-chat", groupId);
    }
    SocketService.off("new-group-message", _handleNewMessage);
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
