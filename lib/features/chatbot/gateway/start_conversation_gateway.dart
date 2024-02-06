import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_gateway.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:chatbot/features/chatbot/gateway/start_conversation_request.dart';
import 'package:chatbot/features/chatbot/model/start_conversation_model.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class StartConversationGateway extends APIGateway<
    StartConversationGatewayOutput,
    StartConversationRequest,
    StartConversationSuccessInput> {
  StartConversationGateway({
    ProvidersContext? context,
    required UseCaseProvider useCaseProvider,
  }) : super(
          context: context ?? providersContext,
          provider: useCaseProvider,
        );

  @override
  StartConversationRequest buildRequest(
    StartConversationGatewayOutput output,
  ) {
    return StartConversationRequest();
  }

  @override
  StartConversationSuccessInput onSuccess(
    ChatBotGraphQLSuccessResponse response,
  ) {
    return StartConversationSuccessInput(
        data: StartConversationModel.fromJson(response.data));
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

class StartConversationGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class StartConversationSuccessInput extends SuccessInput {
  const StartConversationSuccessInput({required this.data});

  final StartConversationModel data;
}
