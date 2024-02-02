class AppSettings {
  bool enabledForUser;
  bool updateData;
  bool needsPrivacyConsent;
  App app;

  AppSettings({
    required this.enabledForUser,
    required this.updateData,
    required this.needsPrivacyConsent,
    required this.app,
  });

  factory AppSettings.fromJson(Map<String, dynamic> data) {
    final json = data['messenger'];
    return AppSettings(
      enabledForUser: json['enabledForUser'],
      updateData: json['updateData'],
      needsPrivacyConsent: json['needsPrivacyConsent'],
      app: App.fromJson(json['app']),
    );
  }
}

class App {
  String greetings;
  String intro;
  String tagline;
  String name;
  bool activeMessenger;
  bool? privacyConsentRequired;
  bool inlineNewConversations;
  bool? enableMessengerBranding;
  bool displayLogo;
  bool inBusinessHours;
  String replyTime;
  String logo;
  InboundSettings inboundSettings;
  bool stickyReplyButtons;
  bool? emailRequirement;
  String agentVisibility;
  BusinessBackIn businessBackIn;
  CustomizationColors customizationColors;
  String notificationSound;
  String timezone;
  UserEditorSettings userEditorSettings;
  LeadEditorSettings leadEditorSettings;
  String domainUrl;

  App({
    required this.greetings,
    required this.intro,
    required this.tagline,
    required this.name,
    required this.activeMessenger,
    this.privacyConsentRequired,
    required this.inlineNewConversations,
    this.enableMessengerBranding,
    required this.displayLogo,
    required this.inBusinessHours,
    required this.replyTime,
    required this.logo,
    required this.inboundSettings,
    required this.stickyReplyButtons,
    this.emailRequirement,
    required this.agentVisibility,
    required this.businessBackIn,
    required this.customizationColors,
    required this.notificationSound,
    required this.timezone,
    required this.userEditorSettings,
    required this.leadEditorSettings,
    required this.domainUrl,
  });

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      greetings: json['greetings'],
      intro: json['intro'],
      tagline: json['tagline'],
      name: json['name'],
      activeMessenger: json['activeMessenger'],
      privacyConsentRequired: json['privacyConsentRequired'],
      inlineNewConversations: json['inlineNewConversations'],
      enableMessengerBranding: json['enableMessengerBranding'],
      displayLogo: json['displayLogo'],
      inBusinessHours: json['inBusinessHours'],
      replyTime: json['replyTime'],
      logo: json['logo'],
      inboundSettings: InboundSettings.fromJson(json['inboundSettings']),
      stickyReplyButtons: json['stickyReplyButtons'],
      emailRequirement: json['emailRequirement'],
      agentVisibility: json['agentVisibility'],
      businessBackIn: BusinessBackIn.fromJson(json['businessBackIn']),
      customizationColors:
          CustomizationColors.fromJson(json['customizationColors']),
      notificationSound: json['notificationSound'],
      timezone: json['timezone'],
      userEditorSettings:
          UserEditorSettings.fromJson(json['userEditorSettings']),
      leadEditorSettings:
          LeadEditorSettings.fromJson(json['leadEditorSettings']),
      domainUrl: json['domainUrl'],
    );
  }
}

class InboundSettings {
  Users users;
  bool enabled;
  Visitors visitors;
  String showNewConversationButton;

  InboundSettings({
    required this.users,
    required this.enabled,
    required this.visitors,
    required this.showNewConversationButton,
  });

  factory InboundSettings.fromJson(Map<String, dynamic> json) {
    return InboundSettings(
      users: Users.fromJson(json['users']),
      enabled: json['enabled'],
      visitors: Visitors.fromJson(json['visitors']),
      showNewConversationButton: json['show_new_conversation_button'],
    );
  }
}

class Users {
  bool enabled;
  String segment;
  int idleSessionsAfter;
  bool usersEnableInbound;
  int closeConversationsAfter;
  bool closeConversationsEnabled;

  Users({
    required this.enabled,
    required this.segment,
    required this.idleSessionsAfter,
    required this.usersEnableInbound,
    required this.closeConversationsAfter,
    required this.closeConversationsEnabled,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      enabled: json['enabled'],
      segment: json['segment'],
      idleSessionsAfter: json['idle_sessions_after'],
      usersEnableInbound: json['users_enable_inbound'],
      closeConversationsAfter: json['close_conversations_after'],
      closeConversationsEnabled: json['close_conversations_enabled'],
    );
  }
}

class Visitors {
  bool enabled;
  String segment;
  int idleSessionsAfter;
  bool idleSessionsEnabled;
  bool visitorsEnableInbound;
  int closeConversationsAfter;
  bool closeConversationsEnabled;

  Visitors({
    required this.enabled,
    required this.segment,
    required this.idleSessionsAfter,
    required this.idleSessionsEnabled,
    required this.visitorsEnableInbound,
    required this.closeConversationsAfter,
    required this.closeConversationsEnabled,
  });

  factory Visitors.fromJson(Map<String, dynamic> json) {
    return Visitors(
      enabled: json['enabled'],
      segment: json['segment'],
      idleSessionsAfter: json['idle_sessions_after'],
      idleSessionsEnabled: json['idle_sessions_enabled'],
      visitorsEnableInbound: json['visitors_enable_inbound'],
      closeConversationsAfter: json['close_conversations_after'],
      closeConversationsEnabled: json['close_conversations_enabled'],
    );
  }
}

class BusinessBackIn {
  String at;
  double diff;
  double days;

  BusinessBackIn({
    required this.at,
    required this.diff,
    required this.days,
  });

  factory BusinessBackIn.fromJson(Map<String, dynamic> json) {
    return BusinessBackIn(
      at: json['at'],
      diff: json['diff'],
      days: json['days'],
    );
  }
}

class CustomizationColors {
  String primary;
  String secondary;

  CustomizationColors({
    required this.primary,
    required this.secondary,
  });

  factory CustomizationColors.fromJson(Map<String, dynamic> json) {
    return CustomizationColors(
      primary: json['primary'],
      secondary: json['secondary'],
    );
  }
}

class UserEditorSettings {
  bool gif;
  bool emojis;
  bool attachments;

  UserEditorSettings({
    required this.gif,
    required this.emojis,
    required this.attachments,
  });

  factory UserEditorSettings.fromJson(Map<String, dynamic> json) {
    return UserEditorSettings(
      gif: json['gif'],
      emojis: json['emojis'],
      attachments: json['attachments'],
    );
  }
}

class LeadEditorSettings {
  bool gif;
  bool emojis;
  bool attachments;

  LeadEditorSettings({
    required this.gif,
    required this.emojis,
    required this.attachments,
  });

  factory LeadEditorSettings.fromJson(Map<String, dynamic> json) {
    return LeadEditorSettings(
      gif: json['gif'],
      emojis: json['emojis'],
      attachments: json['attachments'],
    );
  }
}
