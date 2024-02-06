import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:clean_framework_graphql/src/graphql_error_policy.dart';
import 'package:clean_framework_graphql/src/graphql_fetch_policy.dart';

abstract class ChatBotGraphQLRequest extends Request {
  String get document;

  Map<String, dynamic>? get variables => null;

  Duration? get timeout => null;

  GraphQLFetchPolicy? get fetchPolicy => null;

  GraphQLErrorPolicy? get errorPolicy => null;
}

abstract class QueryGraphQLRequest extends ChatBotGraphQLRequest {}

abstract class MutationGraphQLRequest extends ChatBotGraphQLRequest {}
