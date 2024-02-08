import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:equatable/equatable.dart';

class InitCommandModel extends Equatable {
  final String command;
  final String identifier;
  final String? data;

  const InitCommandModel({
    required this.command,
    required this.identifier,
    required this.data,
  });

  @override
  List<Object?> get props => [command, identifier, data];

  Map<String, dynamic> toJson() {
    return {'command': command, 'identifier': identifier, 'data': data};
  }

  Map<String, dynamic> toJsonWithoutData() {
    return {'command': command, 'identifier': identifier};
  }
}

class Identifier extends Equatable {
  final String app;
  final String channel;
  final String sessionId;
  final String encData;
  final String? sessionValue;
  final String userData;
  const Identifier({
    required this.app,
    required this.channel,
    required this.sessionId,
    required this.encData,
    required this.sessionValue,
    required this.userData,
  });

  factory Identifier.fromJson(Map<String, dynamic> json) {
    return Identifier(
      app: json['app'],
      channel: json['channel'],
      sessionId: json['session_id'],
      encData: json['enc_data'],
      sessionValue: json['session_value'],
      userData: json['user_data'],
    );
  }

  @override
  List<Object?> get props =>
      [app, channel, sessionId, encData, sessionValue, userData];

  Map<String, dynamic> toJson() {
    return {
      'app': app,
      'channel': channel,
      'session_id': sessionId,
      'enc_data': encData,
      'session_value': sessionValue,
      'user_data': userData,
    };
  }
}

class Data extends Equatable {
  final dynamic conversation;
  final dynamic trigger;
  final String action;
  final String? title;
  final String? url;
  final String? browserVersion;
  final String? browserName;
  final String? osVersion;
  final String? os;
  final String? conversationKey;
  final String? messageKey;
  final String? pathId;
  final String? step;
  final Block? reply;

  const Data({
    required this.conversation,
    required this.trigger,
    required this.action,
    this.title,
    this.url,
    this.browserVersion,
    this.browserName,
    this.osVersion,
    this.os,
    this.conversationKey,
    this.messageKey,
    this.pathId,
    this.step,
    this.reply,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      conversation: json['conversation'],
      trigger: json['trigger'],
      action: json['action'],
    );
  }

  @override
  List<Object?> get props => [conversation, trigger, action];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {'action': action};

    if (trigger != null) {
      data['trigger'] = trigger;
    }

    if (conversation != null) {
      data['conversation'] = conversation;
    }
    if (title != null) {
      data['title'] = title;
    }
    if (url != null) {
      data['url'] = url;
    }
    if (browserVersion != null) {
      data['browser_version'] = browserVersion;
    }
    if (browserName != null) {
      data['browser_name'] = browserName;
    }
    if (osVersion != null) {
      data['os_version'] = osVersion;
    }
    if (os != null) {
      data['os'] = os;
    }

    if (conversationKey != null) {
      data['conversation_key'] = conversationKey;
    }
    if (messageKey != null) {
      data['message_key'] = messageKey;
    }
    if (pathId != null) {
      data['path_id'] = pathId;
    }

    if (step != null) {
      data['step'] = step;
    }
    if (reply != null) {
      data['reply'] = reply!.toJson();
    }
    return data;
  }
}
