import 'package:chatbot/core/dependency/graphql/chatbot_graphql_request.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_service.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class ChatBotGraphQLExternalInterface extends ExternalInterface<
    ChatBotGraphQLRequest, ChatBotGraphQLSuccessResponse> {
  ChatBotGraphQLExternalInterface({
    required String link,
    required List<GatewayConnection<Gateway>> gatewayConnections,
    GraphQLToken? token,
    GraphQLPersistence persistence = const GraphQLPersistence(),
    Map<String, String> headers = const {},
    Duration? timeout,
  })  : headerData = headers,
        service = ChatBotGraphQLService(
          endpoint: link,
          token: token,
          persistence: persistence,
          headers: headers,
          timeout: timeout,
        ),
        super(gatewayConnections);

  ChatBotGraphQLExternalInterface.withService({
    required List<GatewayConnection<Gateway>> gatewayConnections,
    required this.service,
    required this.headerData,
  }) : super(gatewayConnections);

  final ChatBotGraphQLService service;
  final Map<String, String> headerData;

  @override
  void handleRequest() {
    on<QueryGraphQLRequest>(
      (request, send) async {
        final response = await service.request(
            method: GraphQLMethod.query,
            document: request.document,
            variables: request.variables,
            timeout: request.timeout,
            fetchPolicy: request.fetchPolicy,
            errorPolicy: request.errorPolicy,
            headers: headerData);
        send(
          ChatBotGraphQLSuccessResponse(
              data: response.data, errors: response.errors),
        );
      },
    );

    on<MutationGraphQLRequest>(
      (request, send) async {
        final response = await service.request(
            method: GraphQLMethod.mutation,
            document: request.document,
            variables: request.variables,
            timeout: request.timeout,
            fetchPolicy: request.fetchPolicy,
            errorPolicy: request.errorPolicy,
            headers: headerData);

        send(
          ChatBotGraphQLSuccessResponse(
              data: response.data, errors: response.errors),
        );
      },
    );
  }

  @override
  FailureResponse onError(Object error) {
    if (error is GraphQLOperationException) {
      return const GraphQLFailureResponse(type: GraphQLFailureType.operation);
    } else if (error is GraphQLNetworkException) {
      return GraphQLFailureResponse(
        type: GraphQLFailureType.network,
        message: error.message ?? '',
        errorData: {'url': error.uri.toString()},
      );
    } else if (error is GraphQLServerException) {
      return GraphQLFailureResponse(
        type: GraphQLFailureType.server,
        message: error.originalException.toString(),
        errorData: error.errorData ?? {},
      );
    } else if (error is GraphQLTimeoutException) {
      return const GraphQLFailureResponse(
        type: GraphQLFailureType.timeout,
        message: 'Connection Timeout',
      );
    }

    return UnknownFailureResponse(error);
  }
}
