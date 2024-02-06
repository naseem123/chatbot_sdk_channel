import 'package:chatbot/core/dependency/graphql/chatbot_graphql_request.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

abstract class APIGateway<O extends Output, R extends ChatBotGraphQLRequest,
        S extends SuccessInput>
    extends Gateway<O, R, ChatBotGraphQLSuccessResponse, S> {
  APIGateway({
    super.context,
    super.provider,
    super.useCase,
  });

  @override
  FailureInput onFailure(GraphQLFailureResponse failureResponse) {
    return APIFailureInput(
      message: failureResponse.message,
      code: failureResponse.errorData['code']! as String,
      traceID: failureResponse.errorData.containsKey('traceID')
          ? failureResponse.errorData['traceID']! as String
          : '',
    );
  }
}

class APIFailureInput extends FailureInput {
  const APIFailureInput({
    super.message,
    this.code = '',
    this.traceID = '',
  });

  final String code;
  final String traceID;
}
