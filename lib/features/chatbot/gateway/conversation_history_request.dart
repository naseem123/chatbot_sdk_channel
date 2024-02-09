import 'package:chatbot/core/dependency/graphql/api_requests.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

class ConversationHistoryRequest extends QueryAPIRequest {
  final String id;
  final int page;

  ConversationHistoryRequest({required this.id, required this.page});

  @override
  String get document => r'''

  query Messenger($id: String!, $page: Int){
    messenger {

      conversation(id: $id){
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
        mainParticipant{
          id
          properties
          displayName
          avatarUrl
        }
        
        messages(page: $page){
          collection{
            id
            key
            message{
              htmlContent
              textContent
              serializedContent
              blocks
              data
              action
              state
            }
            source
            readAt
            createdAt
            privateNote
            stepId
            triggerId
            fromBot
            appUser{
              id
              kind
              displayName
              avatarUrl
            }
            source
            messageSource {
              name
              state
              fromName
              fromEmail
              serializedContent
            }
            emailMessageId
          }
          meta
        }
    }
  }
}
  ''';

  @override
  Map<String, dynamic> get variables {
    return {'id': id, 'page': page};
  }

  @override
  GraphQLFetchPolicy? get fetchPolicy => GraphQLFetchPolicy.networkOnly;
}
