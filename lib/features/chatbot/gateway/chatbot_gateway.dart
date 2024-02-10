import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_gateway.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_request.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class ChatBotGateway extends APIGateway<ChatBotGatewayOutput,
    ChatBotConversationRequest, ChatBotSuccessInput> {
  ChatBotGateway({
    ProvidersContext? context,
    required UseCaseProvider useCaseProvider,
  }) : super(
          context: context ?? providersContext,
          provider: useCaseProvider,
        );

  @override
  ChatBotConversationRequest buildRequest(
    ChatBotGatewayOutput output,
  ) {
    return ChatBotConversationRequest(
        page: output.page, perPage: output.perPage);
  }

  @override
  ChatBotSuccessInput onSuccess(
    ChatBotGraphQLSuccessResponse response,
  ) {
    return ChatBotSuccessInput(
        chatList: ChatConversationModel.fromJson(response.data));
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

class ChatBotGatewayOutput extends Output {
  final int page, perPage;

  const ChatBotGatewayOutput({required this.page, required this.perPage});

  @override
  List<Object?> get props => [page, perPage];
}

class ChatBotSuccessInput extends SuccessInput {
  const ChatBotSuccessInput({required this.chatList});

  final ChatConversationModel chatList;
}
