import 'package:clean_framework/clean_framework.dart';

class AppSettings extends Equatable {
  final bool enabledForUser;
  final bool updateData;
  final bool needsPrivacyConsent;
  final App app;

  const AppSettings({
    this.enabledForUser = false,
    this.updateData = false,
    this.needsPrivacyConsent = false,
    this.app = const App(),
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

  @override
  List<Object?> get props => [
        enabledForUser,
        updateData,
        needsPrivacyConsent,
        app,
      ];
}

class App extends Equatable {
  final String greetings;
  final String intro;
  final String tagline;
  final String name;
  final bool activeMessenger;
  final bool privacyConsentRequired;
  final bool inlineNewConversations;
  final bool enableMessengerBranding;
  final bool displayLogo;
  final bool inBusinessHours;
  final String replyTime;
  final String logo;
  final InboundSettings inboundSettings;
  final bool stickyReplyButtons;
  final String agentVisibility;
  final BusinessBackIn businessBackIn;
  final CustomizationColors customizationColors;
  final String notificationSound;
  final String timezone;
  final UserEditorSettings userEditorSettings;
  final LeadEditorSettings leadEditorSettings;
  final String domainUrl;

  const App({
    this.greetings = "",
    this.intro = "",
    this.tagline = "",
    this.name = "",
    this.activeMessenger = false,
    this.privacyConsentRequired = false,
    this.inlineNewConversations = false,
    this.enableMessengerBranding = false,
    this.displayLogo = false,
    this.inBusinessHours = false,
    this.replyTime = "auto",
    this.logo = "",
    this.inboundSettings = const InboundSettings(),
    this.stickyReplyButtons = false,
    this.agentVisibility = "",
    this.businessBackIn = const BusinessBackIn(),
    this.customizationColors = const CustomizationColors(),
    this.notificationSound = "",
    this.timezone = "",
    this.userEditorSettings = const UserEditorSettings(),
    this.leadEditorSettings = const LeadEditorSettings(),
    this.domainUrl = "",
  });

  factory App.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return App(
      greetings: data.getString('greetings'),
      intro: data.getString('intro'),
      tagline: data.getString('tagline'),
      name: data.getString('name'),
      activeMessenger: data.getBool('activeMessenger', defaultValue: false),
      privacyConsentRequired:
          data.getBool('privacyConsentRequired', defaultValue: false),
      inlineNewConversations:
          data.getBool('inlineNewConversations', defaultValue: false),
      enableMessengerBranding:
          data.getBool('enableMessengerBranding', defaultValue: false),
      displayLogo: data.getBool('displayLogo', defaultValue: false),
      inBusinessHours: data.getBool('inBusinessHours', defaultValue: false),
      replyTime: data.getString('replyTime'),
      logo: data.getString('logo'),
      inboundSettings: InboundSettings.fromJson(data.getMap('inboundSettings')),
      stickyReplyButtons: json['stickyReplyButtons'],
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

  @override
  List<Object?> get props => [
        greetings,
        intro,
        tagline,
        name,
        activeMessenger,
        privacyConsentRequired,
        inlineNewConversations,
        enableMessengerBranding,
        displayLogo,
        inBusinessHours,
        replyTime,
        logo,
        inboundSettings,
        stickyReplyButtons,
        agentVisibility,
        businessBackIn,
        customizationColors,
        notificationSound,
        timezone,
        userEditorSettings,
        leadEditorSettings,
        domainUrl,
      ];
}

class InboundSettings extends Equatable {
  final Users users;
  final bool enabled;
  final Visitors visitors;
  final String showNewConversationButton;

  const InboundSettings({
    this.users = const Users(),
    this.enabled = false,
    this.visitors = const Visitors(),
    this.showNewConversationButton = "",
  });

  factory InboundSettings.fromJson(Map<String, dynamic> json) {
    return InboundSettings(
      users: Users.fromJson(json['users']),
      enabled: json['enabled'],
      visitors: Visitors.fromJson(json['visitors']),
      showNewConversationButton: json['show_new_conversation_button'],
    );
  }

  @override
  List<Object?> get props => [
        users,
        enabled,
        visitors,
        showNewConversationButton,
      ];
}

class Users extends Equatable {
  final bool enabled;
  final String segment;
  final int idleSessionsAfter;
  final bool usersEnableInbound;
  final int closeConversationsAfter;
  final bool closeConversationsEnabled;

  const Users({
    this.enabled = false,
    this.segment = "",
    this.idleSessionsAfter = 0,
    this.usersEnableInbound = false,
    this.closeConversationsAfter = 0,
    this.closeConversationsEnabled = false,
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

class Visitors extends Equatable {
  final bool enabled;
  final String segment;
  final int idleSessionsAfter;
  final bool idleSessionsEnabled;
  final bool visitorsEnableInbound;
  final int closeConversationsAfter;
  final bool closeConversationsEnabled;

  const Visitors({
    this.enabled = false,
    this.segment = "",
    this.idleSessionsAfter = 0,
    this.idleSessionsEnabled = false,
    this.visitorsEnableInbound = false,
    this.closeConversationsAfter = 0,
    this.closeConversationsEnabled = false,
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

class BusinessBackIn extends Equatable {
  final String at;
  final double diff;
  final double days;

  const BusinessBackIn({
    this.at = "",
    this.diff = 0.0,
    this.days = 0.0,
  });

  factory BusinessBackIn.fromJson(Map<String, dynamic> json) {
    return BusinessBackIn(
      at: json['at'],
      diff: json['diff'],
      days: json['days'],
    );
  }

  @override
  List<Object?> get props => [
        at,
        diff,
        days,
      ];
}

class CustomizationColors extends Equatable {
  final String primary;
  final String secondary;

  const CustomizationColors({
    this.primary = "#FF525252",
    this.secondary = "#FFD57B00",
  });

  factory CustomizationColors.fromJson(Map<String, dynamic> json) {
    return CustomizationColors(
      primary: json['primary'],
      secondary: json['secondary'],
    );
  }

  @override
  List<Object?> get props => [
        primary,
        secondary,
      ];
}

class UserEditorSettings extends Equatable {
  final bool gif;
  final bool emojis;
  final bool attachments;

  const UserEditorSettings({
    this.gif = false,
    this.emojis = false,
    this.attachments = false,
  });

  factory UserEditorSettings.fromJson(Map<String, dynamic> json) {
    return UserEditorSettings(
      gif: json['gif'],
      emojis: json['emojis'],
      attachments: json['attachments'],
    );
  }

  @override
  List<Object?> get props => [
        gif,
        emojis,
        attachments,
      ];
}

class LeadEditorSettings extends Equatable {
  final bool gif;
  final bool emojis;
  final bool attachments;

  const LeadEditorSettings({
    this.gif = false,
    this.emojis = false,
    this.attachments = false,
  });

  factory LeadEditorSettings.fromJson(Map<String, dynamic> json) {
    return LeadEditorSettings(
      gif: json['gif'],
      emojis: json['emojis'],
      attachments: json['attachments'],
    );
  }

  @override
  List<Object?> get props => [
        gif,
        emojis,
        attachments,
      ];
}
