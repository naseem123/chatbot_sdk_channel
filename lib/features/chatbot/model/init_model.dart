import 'package:clean_framework/clean_framework.dart';

class InitModel extends Equatable {
  final UserSettings user;
  final AppSettings app;

  const InitModel({required this.user, required this.app});

  factory InitModel.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    final messengerData = Deserializer(data.getMap('messenger'));
    return InitModel(
      user: UserSettings.fromJson(messengerData.getMap('user')),
      app: AppSettings.fromJson(messengerData.getMap('app')),
    );
  }

  @override
  List<Object?> get props => [user, app];
}

class UserSettings extends Equatable {
  final String lang;
  final String sessionId;

  const UserSettings({required this.lang, required this.sessionId});

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return UserSettings(
      lang: data.getString('lang'),
      sessionId: data.getString('sessionId'),
    );
  }

  @override
  List<Object?> get props => [lang, sessionId];
}

class AppSettings extends Equatable {
  final InboundSettings inboundSettings;

  const AppSettings({required this.inboundSettings});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);

    return AppSettings(
      inboundSettings: InboundSettings.fromJson(data.getMap('inboundSettings')),
    );
  }

  @override
  List<Object?> get props => [inboundSettings];
}

class InboundSettings extends Equatable {
  final UsersSettings users;
  final VisitorsSettings visitors;
  final String showNewConversationButton;

  const InboundSettings(
      {required this.users,
      required this.visitors,
      required this.showNewConversationButton});

  factory InboundSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);

    return InboundSettings(
      users: UsersSettings.fromJson(data.getMap('users')),
      visitors: VisitorsSettings.fromJson(data.getMap('visitors')),
      showNewConversationButton: data.getString('show_new_conversation_button'),
    );
  }

  @override
  List<Object?> get props => [users, visitors, showNewConversationButton];
}

class UsersSettings extends Equatable {
  final bool enabled;
  final String segment;
  final int idleSessionsAfter;
  final bool usersEnableInbound;
  final int closeConversationsAfter;
  final bool closeConversationsEnabled;

  const UsersSettings({
    required this.enabled,
    required this.segment,
    required this.idleSessionsAfter,
    required this.usersEnableInbound,
    required this.closeConversationsAfter,
    required this.closeConversationsEnabled,
  });

  factory UsersSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return UsersSettings(
      enabled: data.getBool('enabled'),
      segment: data.getString('segment'),
      idleSessionsAfter: data.getInt('idle_sessions_after'),
      usersEnableInbound: data.getBool('users_enable_inbound'),
      closeConversationsAfter: data.getInt('close_conversations_after'),
      closeConversationsEnabled: data.getBool('close_conversations_enabled'),
    );
  }

  @override
  List<Object?> get props => [
        enabled,
        segment,
        idleSessionsAfter,
        usersEnableInbound,
        closeConversationsAfter,
        closeConversationsEnabled,
      ];
}

class VisitorsSettings extends Equatable {
  final bool enabled;
  final String segment;
  final int idleSessionsAfter;
  final bool idleSessionsEnabled;
  final bool visitorsEnableInbound;
  final int closeConversationsAfter;
  final bool closeConversationsEnabled;

  const VisitorsSettings({
    required this.enabled,
    required this.segment,
    required this.idleSessionsAfter,
    required this.idleSessionsEnabled,
    required this.visitorsEnableInbound,
    required this.closeConversationsAfter,
    required this.closeConversationsEnabled,
  });

  factory VisitorsSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return VisitorsSettings(
      enabled: data.getBool('enabled'),
      segment: data.getString('segment'),
      idleSessionsAfter: data.getInt('idle_sessions_after'),
      idleSessionsEnabled: data.getBool('idle_sessions_enabled'),
      visitorsEnableInbound: data.getBool('visitors_enable_inbound'),
      closeConversationsAfter: data.getInt('close_conversations_after'),
      closeConversationsEnabled: data.getBool('close_conversations_enabled'),
    );
  }

  @override
  List<Object?> get props => [
        enabled,
        segment,
        idleSessionsAfter,
        idleSessionsEnabled,
        visitorsEnableInbound,
        closeConversationsAfter,
        closeConversationsEnabled,
      ];
}
