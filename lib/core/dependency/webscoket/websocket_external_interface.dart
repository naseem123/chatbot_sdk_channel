import 'package:chatbot/core/dependency/webscoket/service/websocket_service.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

Map<String, String> _headers = {
  'app': "yB9BJmrcH3bM4CShtMKB5qrw",
  'content-type': "application/json",
  'lang': "en-GB",
  'origin': "https://test.ca.digital-front-door.stg.gcp.trchq.com",
  'session-id': "DNrMhDXd6Ne6raznT7ZQWA",
  'User-Data':
      '{"email":"test@test.cl","properties":{"name":"Alex","lang":"en","id":"localhost","country":"Canada","role":"admin","pro":null,"num_devices":2,"last_sign_in":"2024-01-30T07:52:37.699Z"},"identifier_key":"3c59d7cd213e20a5cbd7baad3a073b618e2b694151b11dfbb5be80b71f4dc143"}'
};

class WebsocketExternalInterface
    extends ExternalInterface<WebsocketRequest, WebsocketSuccessResponse> {
  WebsocketExternalInterface({
    required String link,
    required List<GatewayConnection<Gateway>> gatewayConnections,
    WebsocketService? websocketService,
  })  : _websocketService =
            websocketService ?? WebsocketService(webSocketURL: link),
        super(gatewayConnections);

  final WebsocketService _websocketService;

  @override
  void handleRequest() {
    on<ConnectWebsocketRequest>(
      (request, send) async {
        _websocketService.initializeControllers();
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
      },
    );

    on<SendMessageToSocketRequest>(
      (request, send) async {
        _websocketService.send(request.messageData);
        send(_successResponse);
      },
    );
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
