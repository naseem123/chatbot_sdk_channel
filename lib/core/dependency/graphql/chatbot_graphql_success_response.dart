import 'package:chatbot/core/dependency/graphql/chatbot_graphql_service.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class ChatBotGraphQLSuccessResponse extends SuccessResponse {
  const ChatBotGraphQLSuccessResponse({
    required this.data,
    this.errors = const [],
  });

  final Map<String, dynamic> data;
  final Iterable<GraphQLOperationError> errors;
}

class GraphQLFailureResponse extends TypedFailureResponse<GraphQLFailureType> {
  const GraphQLFailureResponse({
    required super.type,
    super.message,
    super.errorData,
  });
}

enum GraphQLFailureType { operation, network, server, timeout }
