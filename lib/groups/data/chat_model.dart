class ChatMessage {
  final String senderName;
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.senderName,
    required this.message,
    required this.time,
    required this.isMe,
  });
}
