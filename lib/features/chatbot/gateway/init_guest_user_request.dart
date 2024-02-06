import 'package:chatbot/core/dependency/graphql/api_requests.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

class InitGuestUserRequest extends QueryAPIRequest {
  @override
  String get document => r'''
  query Messenger{
      messenger {
        user {
          sessionId
        }
        app {
          inboundSettings
        }
      }
    }
  ''';

  @override
  GraphQLFetchPolicy? get fetchPolicy => GraphQLFetchPolicy.networkOnly;
}
