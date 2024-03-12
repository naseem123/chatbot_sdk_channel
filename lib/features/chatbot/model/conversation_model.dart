import 'package:chatbot/core/extensions/date_extensions.dart';
import 'package:clean_framework/clean_framework.dart';

class ChatConversationModel extends Equatable {
  final ConversationMeta conversationMeta;
  final List<Conversation> conversations;

  const ChatConversationModel(
      {required this.conversationMeta, this.conversations = const []});

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    final Map desJson = data.getMap('messenger')['conversations'];

    return ChatConversationModel(
      conversations: (desJson['collection'] as List)
          .map((e) => Conversation.fromJson(e))
          .toList(),
      conversationMeta: ConversationMeta.fromJson(desJson['meta']),
    );
  }

  @override
  List<Object> get props => [conversationMeta, conversations];
}

class Conversation extends Equatable {
  final String id;
  final String key;
  final String state;
  final String participantName;
  final String? participantAvatar;
  final String? closedAt;
  final String? assigneeAvatar;
  final String assigneeName;
  final LastMessage lastMessage;
  final DateTime? lastUpdatedTime;

  const Conversation({
    required this.id,
    required this.key,
    required this.state,
    required this.assigneeAvatar,
    required this.closedAt,
    required this.lastMessage,
    required this.assigneeName,
    required this.participantAvatar,
    required this.lastUpdatedTime,
    required this.participantName,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      key: json['key'],
      state: json['state'],
      assigneeName: json['assignee']['displayName'],
      closedAt: json['closedAt'],
      assigneeAvatar: json['assignee']['avatarUrl'],
      lastMessage: LastMessage.fromJson(json['lastMessage']),
      participantName: json['mainParticipant']?['displayName'],
      participantAvatar: json['mainParticipant']['avatarUrl'],
      lastUpdatedTime: json['lastMessage']['createdAt'] != null
          ? DateTime.parse(json['lastMessage']['createdAt'])
          : null,
    );
  }

  bool get isOpen => state == 'opened';

  String get lastUpdatedTimeText =>
      lastUpdatedTime != null ? lastUpdatedTime!.timeAgo : '';

  @override
  List<Object?> get props => [
        id,
        key,
        state,
        assigneeAvatar,
        closedAt,
        lastMessage,
        assigneeName,
        participantAvatar,
        lastUpdatedTime,
        participantName,
      ];
}

class LastMessage {
  String createdAt;
  String stepId;
  String triggerId;
  bool fromBot;
  String key;
  Message message;

  LastMessage({
    required this.createdAt,
    required this.stepId,
    required this.triggerId,
    required this.fromBot,
    required this.key,
    required this.message,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return LastMessage(
      createdAt: data.getString('createdAt'),
      stepId: data.getString('stepId'),
      triggerId: data.getString('triggerId'),
      fromBot: data.getBool('fromBot'),
      key: data.getString('key'),
      message: Message.fromJson(data.getMap('message')),
    );
  }
}

class Message {
  // Assuming that "blocks" is a Map<String, dynamic>
  Map<String, dynamic>? blocks;
  String? serializedContent;

  // Add other properties as needed

  Message({
    this.blocks,
    this.serializedContent,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return Message(
      blocks: data.getMap('blocks'),
      serializedContent: data.getString('serializedContent'),
      // Add other properties as needed
    );
  }
}

class ConversationMeta {
  final int currentPage;
  final int? nextPage;
  final int? prevPage;
  final int totalPages;
  final int totalCount;

  const ConversationMeta({
    this.currentPage = 0,
    this.nextPage = 0,
    this.prevPage = 0,
    this.totalPages = 0,
    this.totalCount = 0,
  });

  factory ConversationMeta.fromJson(Map<String, dynamic> json) {
    return ConversationMeta(
      currentPage: json['current_page'],
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
      totalPages: json['total_pages'],
      totalCount: json['total_count'],
    );
  }
}
