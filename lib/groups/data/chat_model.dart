import 'package:intl/intl.dart';

class ChatMessage {
  final String? id;
  final String? senderName;
  final String? senderImage;
  final String? senderId;
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    this.id,
    this.senderName,
    this.senderImage,
    this.senderId,
    required this.message,
    required this.time,
    required this.isMe,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json, String currentUserId) {
    final sender = json['senderId'];
    String name = "Unknown";
    String? image;
    String? sId;

    if (sender is Map<String, dynamic>) {
      name = sender['fullName'] ?? "Unknown";
      image = sender['image'];
      sId = sender['_id'];
    } else if (sender is String) {
      sId = sender;
    }

    final createdAt = json['createdAt'] != null 
        ? DateTime.parse(json['createdAt']).toLocal() 
        : DateTime.now();

    return ChatMessage(
      id: json['_id'],
      senderName: name,
      senderImage: image,
      senderId: sId,
      message: json['text'] ?? "",
      time: DateFormat('hh:mm a').format(createdAt),
      isMe: sId == currentUserId,
    );
  }
}
