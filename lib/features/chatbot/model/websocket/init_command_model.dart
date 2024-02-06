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
  final String trigger;
  final String action;

  const Data({
    required this.conversation,
    required this.trigger,
    required this.action,
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
    return {
      'conversation': conversation,
      'trigger': trigger,
      'action': action,
    };
  }
}
