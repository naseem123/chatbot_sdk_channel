import 'package:chatbot/core/dependency/graphql/api_persistence.dart';
import 'package:chatbot/core/dependency/graphql/api_requests.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_external_interface.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_service.dart';
import 'package:chatbot/core/dependency/graphql/chatbot_graphql_success_response.dart';
import 'package:chatbot/core/utils/shared_pref.dart';
import 'package:chatbot/providers.dart';
import 'package:clean_framework/clean_framework.dart';

Map<String, String> _headers = {};

class APIExternalInterface extends ChatBotGraphQLExternalInterface {
  APIExternalInterface({
    required String link,
    required String appId,
    required super.gatewayConnections,
  })  : _baseURL = link,
        _appID = appId,
        super(
          link: '$link/api/graphql',
          persistence: APIPersistence(),
          headers: _headers,
          timeout: const Duration(seconds: 90),
        );

  final String _baseURL;
  final String _appID;

  @override
  void handleRequest() {
    on<QueryAPIRequest>(
      (request, send) async {
        await _transformHeader();
        _logRequestHeaders();
        final response = await service.request(
            method: GraphQLMethod.query,
            document: request.document,
            variables: request.variables,
            timeout: request.timeout,
            fetchPolicy: request.fetchPolicy,
            headers: _headers);

        send(
          ChatBotGraphQLSuccessResponse(
              data: response.data, errors: response.errors),
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
            headers: _headers);

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

  Future<void> _transformHeader() async {
    String? sessionId = preference.get<String>(PreferenceKey.sessionId, "");

    if (sessionId == null || sessionId.isEmpty) {
      sessionId = DateTime.now()
          .millisecondsSinceEpoch
          .remainder(100000000000000000)
          .toString();
    }
// _headers = {
//       'app': _appID,
//       'session-id':
//       "eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9LWlcxaGFXeEpJaEYwWlhOMFFIUmxjM1F1WTJ3R09nWkZWRG9KZEhsd1pUQT0iLCJleHAiOm51bGwsInB1ciI6ImxvZ2luIn19--8eb78acd4acda60d78a3c17059a4297312469ccb93444d789e64deac0890952f",
//       'origin': _baseURL,
//       'content-type': "application/json",
//       'User-Data':
//       "{\"email\":\"test@test.cl\",\"properties\":{\"name\":\"Alex\",\"lang\":\"en\",\"id\":\"localhost\",\"country\":\"Canada\",\"role\":\"admin\",\"pro\":null,\"num_devices\":2,\"last_sign_in\":\"2024-02-05T04:16:19.206Z\"},\"identifier_key\":\"3c59d7cd213e20a5cbd7baad3a073b618e2b694151b11dfbb5be80b71f4dc143\"}"
//     };
    print('APIExternalInterface._transformHeader $sessionId');
    _headers = {
      'app': _appID,
      'session-id': sessionId,
      'origin': _baseURL,
      'content-type': "application/json"
    };
  }

  Future<void> _logRequestHeaders() async {
    _RequestLogger(endpoint: '$_baseURL/api/graphql', headers: _headers);
  }
}

class _RequestLogger extends NetworkLogger {
  _RequestLogger({
    required this.endpoint,
    required this.headers,
  });

  final String endpoint;
  final Map<String, String> headers;

  @override
  void initialize() {
    printHeader('REQUEST', endpoint);
    _printHeaders();
    printFooter();
  }

  void _printHeaders() {
    if (headers.isNotEmpty) {
      printCategory('Headers');
      printInLines(prettyHeaders(headers));
    }
  }
}
