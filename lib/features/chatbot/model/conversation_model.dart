import 'package:chatbot/core/extensions/date_extensions.dart';
import 'package:clean_framework/clean_framework.dart';

class ChatConversationSuccessInput extends Equatable {
  final ConversationMeta conversationMeta;
  final List<Conversation> conversations;

  const ChatConversationSuccessInput(
      {required this.conversationMeta, required this.conversations});

  factory ChatConversationSuccessInput.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    final Map desJson = data.getMap('messenger')['conversations'];

    return ChatConversationSuccessInput(
      conversations: (desJson['collection'] as List)
          .map((e) => Conversation.fromJson(e))
          .toList(),
      conversationMeta: ConversationMeta.fromJson(desJson['meta']),
    );
  }

  @override
  List<Object> get props => [conversationMeta, conversations];
}

class Conversation {
  String id;
  String key;
  String state;
  String participantName;
  String? participantAvatar;
  String? closedAt;
  String? assigneeAvatar;
  String assigneeName;
  LastMessage lastMessage;
  DateTime? lastUpdatedTime;

  Conversation(
      {required this.id,
      required this.key,
      required this.state,
      required this.assigneeAvatar,
      required this.closedAt,
      required this.lastMessage,
      required this.assigneeName,
      required this.participantAvatar,
      required this.lastUpdatedTime,
      required this.participantName});

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

  // Add other properties as needed

  Message({
    this.blocks,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return Message(
      blocks: data.getMap('blocks'),
      // Add other properties as needed
    );
  }
}

class ConversationMeta {
  int currentPage;
  int? nextPage;
  int? prevPage;
  int totalPages;
  int totalCount;

  ConversationMeta({
    required this.currentPage,
    this.nextPage,
    this.prevPage,
    required this.totalPages,
    required this.totalCount,
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
