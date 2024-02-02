import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

abstract class APIGateway<O extends Output, R extends GraphQLRequest,
    S extends SuccessInput> extends Gateway<O, R, GraphQLSuccessResponse, S> {
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
