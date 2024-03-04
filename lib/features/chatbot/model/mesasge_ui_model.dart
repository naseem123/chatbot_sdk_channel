import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:clean_framework/clean_framework.dart';

abstract class ChatMessage extends Equatable {
  const ChatMessage(
      {this.messageType = MessageType.normalText, this.messageId = ''});

  final MessageType messageType;
  final String messageId;

  @override
  List<Object?> get props => [];
}

class MessageUiModel extends ChatMessage {
  final String message;
  final MessageSenderType messageSenderType;
  final String imageUrl;
  final String createdAt;

  const MessageUiModel({
    required this.message,
    required this.messageSenderType,
    this.imageUrl = "",
    this.createdAt = '',
    super.messageType,
    super.messageId,
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

enum MessageType { normalText, surveyMessage }
