import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_gateway.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:chatbot/features/chatbot/gateway/init_guest_user_request.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/model/init_model.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class InitGuestUserGateway extends APIGateway<InitGuestUserGatewayOutput,
    InitGuestUserRequest, InitGuestUserSuccessInput> {
  InitGuestUserGateway({
    ProvidersContext? context,
    required UseCaseProvider useCaseProvider,
  }) : super(
          context: context ?? providersContext,
          provider: useCaseProvider,
        );

  @override
  InitGuestUserRequest buildRequest(
    InitGuestUserGatewayOutput output,
  ) {
    return InitGuestUserRequest();
  }

  @override
  InitGuestUserSuccessInput onSuccess(
    ChatBotGraphQLSuccessResponse response,
  ) {
    return InitGuestUserSuccessInput(
        initData: InitModel.fromJson(response.data));
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

class InitGuestUserGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class InitGuestUserSuccessInput extends SuccessInput {
  const InitGuestUserSuccessInput({required this.initData});

  final InitModel initData;
}
