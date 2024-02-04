import 'package:chatbot/core/dependency/webscoket/websocket_gateway.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class WebsocketConnectGateway extends WebsocketGateway<
    WebsocketConnectGatewayOutput,
    ConnectWebsocketRequest,
    WebsocketConnectSuccessInput> {
  WebsocketConnectGateway({
    required ProvidersContext context,
    required UseCaseProvider provider,
  }) : super(context: context, provider: provider);

  @override
  ConnectWebsocketRequest buildRequest(
    WebsocketConnectGatewayOutput output,
  ) {
    return ConnectWebsocketRequest();
  }

  @override
  WebsocketConnectSuccessInput onSuccess(
    WebsocketSuccessResponse response,
  ) {
    return WebsocketConnectSuccessInput();
  }
}

class WebsocketConnectGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class WebsocketConnectSuccessInput extends SuccessInput {}
