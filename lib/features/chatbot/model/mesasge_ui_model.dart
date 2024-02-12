import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:clean_framework/clean_framework.dart';

class MessageUiModel extends Equatable {
  final String message;
  final String messageId;
  final MessageSenderType messageSenderType;
  final String imageUrl;
  final String createdAt;

  const MessageUiModel({
    required this.message,
    required this.messageId,
    required this.messageSenderType,
    this.imageUrl = "",
    this.createdAt = '',
  });

  @override
  List<Object?> get props => [
        message,
        messageId,
        messageSenderType,
        imageUrl,
        createdAt,
      ];
}
