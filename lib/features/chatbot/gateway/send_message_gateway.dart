import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_gateway.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:chatbot/features/chatbot/gateway/send_message_request.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class SendMessageGateway extends APIGateway<SendMessageGatewayOutput,
    SendMessageRequest, SendMessageSuccessInput> {
  SendMessageGateway({
    ProvidersContext? context,
    required UseCaseProvider useCaseProvider,
  }) : super(
          context: context ?? providersContext,
          provider: useCaseProvider,
        );

  @override
  SendMessageRequest buildRequest(
    SendMessageGatewayOutput output,
  ) {
    return SendMessageRequest(
      message: output.message,
      appKey: output.appKey,
      conversationId: output.conversationId,
    );
  }

  @override
  SendMessageSuccessInput onSuccess(
    ChatBotGraphQLSuccessResponse response,
  ) {
    return SendMessageSuccessInput(data: response.data);
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

class SendMessageGatewayOutput extends Output {
  final Map<String, dynamic> message;
  final String appKey;
  final String conversationId;

  const SendMessageGatewayOutput(
      {required this.message,
      required this.appKey,
      required this.conversationId});

  @override
  List<Object?> get props => [
        message,
        appKey,
        conversationId,
      ];
}

class SendMessageSuccessInput extends SuccessInput {
  const SendMessageSuccessInput({required this.data});

  final Map<String, dynamic> data;
}
