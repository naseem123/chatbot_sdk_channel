import 'package:chatbot/core/dependency/graphql/api_persistence.dart';
import 'package:chatbot/core/dependency/graphql/api_requests.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

Map<String, String> _headers = {
  'app': "yB9BJmrcH3bM4CShtMKB5qrw",
  'content-type': "application/json",
  'lang': "en-GB",
  'origin': "https://test.ca.digital-front-door.stg.gcp.trchq.com",
  'session-id': "DNrMhDXd6Ne6raznT7ZQWA",
  'User-Data':
      '{"email":"test@test.cl","properties":{"name":"Alex","lang":"en","id":"localhost","country":"Canada","role":"admin","pro":null,"num_devices":2,"last_sign_in":"2024-01-30T07:52:37.699Z"},"identifier_key":"3c59d7cd213e20a5cbd7baad3a073b618e2b694151b11dfbb5be80b71f4dc143"}'
};

class APIExternalInterface extends GraphQLExternalInterface {
  APIExternalInterface({
    required super.link,
    required super.gatewayConnections,
    required GraphQLToken super.token,
  })  : _token = token,
        super(
          persistence: APIPersistence(),
          headers: _headers,
          timeout: const Duration(seconds: 90),
        );

  //TODO use token for authentication
  final GraphQLToken _token;

  @override
  void handleRequest() {
    on<QueryAPIRequest>(
      (request, send) async {
        _transformHeader();

        final response = await service.request(
          method: GraphQLMethod.query,
          document: request.document,
          variables: request.variables,
          timeout: request.timeout,
          fetchPolicy: request.fetchPolicy,
        );
        send(
          GraphQLSuccessResponse(data: response.data, errors: response.errors),
        );
      },
    );

    on<MutationAPIRequest>(
      (request, send) async {
        final response = await service.request(
          method: GraphQLMethod.mutation,
          document: request.document,
          variables: request.variables,
          timeout: request.timeout,
          fetchPolicy: request.fetchPolicy,
        );

        send(
          GraphQLSuccessResponse(data: response.data, errors: response.errors),
        );
      },
    );
  }

  @override
  FailureResponse onError(Object error) {
    if (error is GraphQLOperationException) {
      return GraphQLFailureResponse(
        type: GraphQLFailureType.operation,
        message: error.error != null ? error.error!.message : 'Unknown error',
        errorData: (error.error != null && error.error!.extensions != null)
            ? error.error!.extensions!
            : {'code': 'UNKNOWN_ERROR', 'traceID': ''},
      );
    }
    return super.onError(error);
  }
}

void _transformHeader() {
  //
}
