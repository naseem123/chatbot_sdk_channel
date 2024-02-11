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
        await _transformHeader();
        _logRequestHeaders();
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
