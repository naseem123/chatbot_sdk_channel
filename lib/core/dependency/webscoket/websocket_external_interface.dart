import 'package:chatbot/core/dependency/webscoket/service/websocket_service.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:chatbot/core/utils/shared_pref.dart';
import 'package:chatbot/providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

Map<String, String> _headers = {};

class WebsocketExternalInterface
    extends ExternalInterface<WebsocketRequest, WebsocketSuccessResponse> {
  WebsocketExternalInterface({
    required String link,
    required String appId,
    required String baseURL,
    required List<GatewayConnection<Gateway>> gatewayConnections,
    WebsocketService? websocketService,
  })  : _appId = appId,
        _origin = baseURL,
        _websocketService =
            websocketService ?? WebsocketService(webSocketURL: link),
        super(gatewayConnections);

  final WebsocketService _websocketService;
  final String _appId;
  final String _origin;

  @override
  void handleRequest() {
    on<ConnectWebsocketRequest>(
      (request, send) async {
        _websocketService.initializeControllers();
        _transformHeader();
        _websocketService.connect(
          headers: _headers,
        );
        send(_successResponse);
      },
    );

    on<ListenToSocketRequest>(
      (request, send) async {
        _websocketService.messageUpdates().listen(
          (message) {
            send(WebsocketSuccessResponse(data: message));
          },
        );
        send(_successResponse);
      },
    );

    on<SendMessageToSocketRequest>(
      (request, send) async {
        _websocketService.send(request.messageData);
        send(_successResponse);
      },
    );

    on<DisconnectWebsocketRequest>(
      (request, send) async {
        _websocketService.disconnect();
        send(_successResponse);
      },
    );
  }

  Future<void> _transformHeader() async {
    var sessionId = preference.get<String>(PreferenceKey.sessionId, "");

    if (sessionId == null || sessionId.isEmpty) {
      sessionId = DateTime.now()
          .millisecondsSinceEpoch
          .remainder(100000000000000000)
          .toString();
    }

    _headers = {
      'app': _appId,
      'session-id': sessionId,
      'origin': _origin,
      'user_data': "e30=",
      'content-type': "application/json"
    };
  }

  @override
  FailureResponse onError(Object error) {
    return const WebsocketFailureResponse(
        type: WebsocketFailureType.unAuthenticated);
  }

  WebsocketSuccessResponse get _successResponse {
    return WebsocketSuccessResponse.empty();
  }
}
