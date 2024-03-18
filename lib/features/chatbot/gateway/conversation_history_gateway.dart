import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_gateway.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:chatbot/features/chatbot/gateway/conversation_history_request.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class ConversationHistoryGateway extends APIGateway<
    ConversationHistoryGatewayOutput,
    ConversationHistoryRequest,
    ConversationHistorySuccessInput> {
  ConversationHistoryGateway({
    ProvidersContext? context,
    required UseCaseProvider useCaseProvider,
  }) : super(
          context: context ?? providersContext,
          provider: useCaseProvider,
        );

  @override
  ConversationHistoryRequest buildRequest(
    ConversationHistoryGatewayOutput output,
  ) {
    return ConversationHistoryRequest(
        id: output.conversationID, page: output.page);
  }

  @override
  ConversationHistorySuccessInput onSuccess(
    ChatBotGraphQLSuccessResponse response,
  ) {
    return ConversationHistorySuccessInput(data: response.data);
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    if (failureResponse is GraphQLFailureResponse) {
      return FailureInput(message: failureResponse.message);
    } else {
      return const FailureInput(
        message: 'Unknown Error',
      );
    }
  }
}

class ConversationHistoryGatewayOutput extends Output {
  final String conversationID;
  final int page;
  const ConversationHistoryGatewayOutput({
    required this.conversationID,
    required this.page,
  });

  @override
  List<Object?> get props => [
        conversationID,
        page,
      ];
}

class ConversationHistorySuccessInput extends SuccessInput {
  const ConversationHistorySuccessInput({required this.data});

  final Map<String, dynamic> data;
}
