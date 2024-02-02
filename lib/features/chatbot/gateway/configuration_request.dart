import 'package:chatbot/core/dependency/graphql/api_requests.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

class SDKSettingConfigurationRequest extends QueryAPIRequest {
  SDKSettingConfigurationRequest();

  @override
  String get document => r'''
  query Messenger{
    messenger {
      enabledForUser
      updateData
      needsPrivacyConsent
      app{
        greetings
        intro
        tagline
        name
        activeMessenger
        privacyConsentRequired
        inlineNewConversations
        enableMessengerBranding
        displayLogo
        inBusinessHours
        leadTasksSettings
        userTasksSettings
        replyTime
        logo
        inboundSettings
        stickyReplyButtons
        emailRequirement
        agentVisibility
        businessBackIn
        tasksSettings
        customizationColors
        notificationSound
        searcheableFields
        homeApps
        timezone
        userEditorSettings
        leadEditorSettings
        articleSettings{
          subdomain
        }
        domainUrl
        theme
        fullStory
      }
      agents {
        name
        avatarUrl
      }
    }
  }
  ''';

  @override
  Map<String, dynamic> get variables {
    return {};
  }

  @override
  GraphQLFetchPolicy? get fetchPolicy => GraphQLFetchPolicy.networkOnly;
}
