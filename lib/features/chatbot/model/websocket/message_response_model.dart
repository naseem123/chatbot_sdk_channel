import 'package:equatable/equatable.dart';

class MessageResponseModel extends Equatable {
  final AppUser appUser;
  final int? appUserId;
  final int authorableId;
  final String authorableType;
  final int? boolean;
  final int conversationId;
  final String conversationKey;
  final String createdAt;
  final int? emailMessageId;
  final int id;
  final String key;
  final Message message;
  final int? messageId;
  final String? messageTrigger;
  final int messageableId;
  final String messageableType;
  final String? privateNote;
  final String? readAt;
  final String? source;
  final String stepId;
  final String? string;
  final String triggerId;
  final String updatedAt;

  MessageResponseModel({
    required this.appUser,
    required this.appUserId,
    required this.authorableId,
    required this.authorableType,
    required this.boolean,
    required this.conversationId,
    required this.conversationKey,
    required this.createdAt,
    required this.emailMessageId,
    required this.id,
    required this.key,
    required this.message,
    required this.messageId,
    required this.messageTrigger,
    required this.messageableId,
    required this.messageableType,
    required this.privateNote,
    required this.readAt,
    required this.source,
    required this.stepId,
    required this.string,
    required this.triggerId,
    required this.updatedAt,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      appUser: AppUser.fromJson(json['app_user']),
      appUserId: json['app_user_id'],
      authorableId: json['authorable_id'],
      authorableType: json['authorable_type'],
      boolean: json['boolean'],
      conversationId: json['conversation_id'],
      conversationKey: json['conversation_key'],
      createdAt: json['created_at'],
      emailMessageId: json['email_message_id'],
      id: json['id'],
      key: json['key'],
      message: Message.fromJson(json['message']),
      messageId: json['message_id'],
      messageTrigger: json['message_trigger'],
      messageableId: json['messageable_id'],
      messageableType: json['messageable_type'],
      privateNote: json['private_note'],
      readAt: json['read_at'],
      source: json['source'],
      stepId: json['step_id'],
      string: json['string'],
      triggerId: json['trigger_id'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [
    appUser,
    appUserId,
    authorableId,
    authorableType,
    boolean,
    conversationId,
    conversationKey,
    createdAt,
    emailMessageId,
    id,
    key,
    message,
    messageId,
    messageTrigger,
    messageableId,
    messageableType,
    privateNote,
    readAt,
    source,
    stepId,
    string,
    triggerId,
    updatedAt,
  ];
}

class AppUser extends Equatable {
  final String avatarUrl;
  final String displayName;
  final String email;
  final int id;
  final String kind;

  AppUser({
    required this.avatarUrl,
    required this.displayName,
    required this.email,
    required this.id,
    required this.kind,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      avatarUrl: json['avatar_url'],
      displayName: json['display_name'],
      email: json['email'],
      id: json['id'],
      kind: json['kind'],
    );
  }

  @override
  List<Object?> get props => [avatarUrl, displayName, email, id, kind];
}

class Message extends Equatable {
  final Map<String, dynamic> blocks;
  final String createdAt;
  final dynamic data;
  final int id;
  final dynamic state;
  final String updatedAt;

  Message({
    required this.blocks,
    required this.createdAt,
    required this.data,
    required this.id,
    required this.state,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      blocks: json['blocks'],
      createdAt: json['created_at'],
      data: json['data'],
      id: json['id'],
      state: json['state'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [blocks, createdAt, data, id, state, updatedAt];
}
