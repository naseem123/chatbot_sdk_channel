import 'package:chatbot/core/dependency/graphql/api_requests.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

class SendMessageRequest extends MutationAPIRequest {
  final Map<String, dynamic> message;
  final String appKey;
  final String id;
  SendMessageRequest({
    required this.message,
    required this.appKey,
    required this.id,
  });

  @override
  String get document => r'''
  mutation InsertComment($appKey: String!, $id: String!, $message: MessageInput!){
    insertComment(appKey: $appKey, id: $id, message: $message){
      message{
        message{
          htmlContent
          textContent
          serializedContent
        }
        readAt
        appUser{
          id
          avatarUrl
          kind
          displayName
        }
        source
        key
        messageSource {
          name
          state
          fromName
          fromEmail
          serializedContent
        }
        emailMessageId
      }
    }
  }
  ''';

  @override
  Map<String, dynamic>? get variables => {};

  @override
  GraphQLFetchPolicy? get fetchPolicy => GraphQLFetchPolicy.networkOnly;
}
