import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_request.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

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
    GraphQLSuccessResponse response,
  ) {
    return ChatBotSuccessInput(
        chatList: ChatConversationSuccessInput.fromJson(response.data));
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

  final ChatConversationSuccessInput chatList;
}
