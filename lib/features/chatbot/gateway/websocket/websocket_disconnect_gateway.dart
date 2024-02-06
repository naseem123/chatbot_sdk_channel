import 'package:chatbot/core/dependency/webscoket/websocket_gateway.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class WebsocketDisconnectGateway extends WebsocketGateway<
    WebsocketDisconnectGatewayOutput,
    DisconnectWebsocketRequest,
    WebsocketDisconnectSuccessInput> {
  WebsocketDisconnectGateway({
    required ProvidersContext context,
    required UseCaseProvider provider,
  }) : super(context: context, provider: provider);

  @override
  DisconnectWebsocketRequest buildRequest(
    WebsocketDisconnectGatewayOutput output,
  ) {
    return DisconnectWebsocketRequest();
  }

  @override
  WebsocketDisconnectSuccessInput onSuccess(
    WebsocketSuccessResponse response,
  ) {
    return WebsocketDisconnectSuccessInput();
  }
}

class WebsocketDisconnectGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class WebsocketDisconnectSuccessInput extends SuccessInput {}
