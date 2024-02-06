import 'package:equatable/equatable.dart';

class InitCommandResponseModel extends Equatable {
  final Data data;
  final String type;

  const InitCommandResponseModel({required this.data, required this.type});

  factory InitCommandResponseModel.fromJson(Map<String, dynamic> json) {
    return InitCommandResponseModel(
      data: Data.fromJson(json['data']),
      type: json['type'],
    );
  }

  @override
  List<Object?> get props => [data, type];
}

class Data extends Equatable {
  final AppUser appUser;
  final dynamic appUserId;
  final int authorableId;
  final String authorableType;
  final dynamic boolean;
  final int conversationId;
  final String conversationKey;
  final String createdAt;
  final dynamic emailMessageId;
  final int id;
  final String key;
  final Message message;
  final dynamic messageId;
  final dynamic messageTrigger;
  final String messageableId;
  final String messageableType;
  final dynamic privateNote;
  final dynamic readAt;
  final dynamic source;
  final String stepId;
  final dynamic string;
  final String triggerId;
  final String updatedAt;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
  final Block blocks;
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

class Block extends Equatable {
  final String type;
  final String? label;
  final List<Schema> schema;
  final bool waitForInput;

  Block({
    required this.type,
    required this.label,
    required this.schema,
    required this.waitForInput,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      type: json['type'],
      label: json['label'],
      schema: (json['schema'] as List)
          .map((schemaJson) => Schema.fromJson(schemaJson))
          .toList(),
      waitForInput: json['wait_for_input'],
    );
  }

  @override
  List<Object?> get props => [type, label, schema, waitForInput];
}

class Schema extends Equatable {
  final String element;
  final String id;
  final String label;
  final String? nextStepUuid;
  final String? pathId;
  final Controls? controls;
  final String? stepUid;
  final List<dynamic> messages;

  Schema({
    required this.element,
    required this.id,
    required this.label,
    required this.nextStepUuid,
    required this.pathId,
    required this.controls,
    required this.stepUid,
    required this.messages,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
      element: json['element'],
      id: json['id'],
      label: json['label'],
      nextStepUuid: json['next_step_uuid'],
      pathId: json['path_id'],
      controls:
          json['controls'] != null ? Controls.fromJson(json['controls']) : null,
      stepUid: json['step_uid'],
      messages: json['messages'] ?? [],
    );
  }

  @override
  List<Object?> get props =>
      [element, id, label, nextStepUuid, pathId, controls, stepUid, messages];
}

class Controls extends Equatable {
  final String type;
  final List<Schema> schema;

  Controls({
    required this.type,
    required this.schema,
  });

  factory Controls.fromJson(Map<String, dynamic> json) {
    return Controls(
      type: json['type'],
      schema: (json['schema'] as List)
          .map((schemaJson) => Schema.fromJson(schemaJson))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [type, schema];
}
