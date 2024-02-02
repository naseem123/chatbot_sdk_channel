import 'package:chatbot/core/dependency/graphql/api_requests.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

class ChatBotConversationRequest extends QueryAPIRequest {
  final int page, perPage;

  ChatBotConversationRequest({required this.page, required this.perPage});

  @override
  String get document => r'''
  
  query Messenger($page: Int!, $per: Int){
    messenger {
      conversations(page: $page, per: $per){
        collection{
          id
          key
          state
          readAt
          closedAt
          priority
          assignee {
            id
            displayName
            avatarUrl
          }
          lastMessage{
            source
            createdAt
            stepId
            triggerId
            fromBot
            readAt
            key
            message{
              htmlContent
              textContent
              serializedContent
              blocks
              action
              data
            }
            privateNote
            messageSource{
              id
              type
            }
            appUser {
              id
              kind
              displayName
              avatarUrl
            }
          }
          mainParticipant{
            id
            displayName
            properties
            avatarUrl
          }
        }
        meta
      }
    }
  }
  ''';

  @override
  Map<String, dynamic> get variables {
    return {'page': page, 'per': perPage};
  }

  @override
  GraphQLFetchPolicy? get fetchPolicy => GraphQLFetchPolicy.networkOnly;
}
