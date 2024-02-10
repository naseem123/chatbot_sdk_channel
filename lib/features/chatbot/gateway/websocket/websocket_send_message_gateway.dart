import 'dart:convert';
import 'package:chatbot/core/dependency/webscoket/websocket_gateway.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:chatbot/features/chatbot/model/websocket_message_model.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class WebsocketSendMessageGateway extends WebsocketGateway<
    WebsocketSendMessageGatewayOutput,
    SendMessageToSocketRequest,
    WebsocketSendMessageSuccessInput> {
  WebsocketSendMessageGateway({
    required ProvidersContext context,
    required UseCaseProvider provider,
  }) : super(context: context, provider: provider);

  @override
  SendMessageToSocketRequest buildRequest(
    WebsocketSendMessageGatewayOutput output,
  ) {
    // var payload = {'event': 'message.create', 'data': output.messageToSend.toJson()};
    var payload = {'data': output.messageToSend.toJson()};
    return SendMessageToSocketRequest(messageData: jsonEncode(payload));
  }

  @override
  WebsocketSendMessageSuccessInput onSuccess(
    WebsocketSuccessResponse response,
  ) {
    return WebsocketSendMessageSuccessInput();
  }
}

class WebsocketSendMessageGatewayOutput extends Output {
  final WebsocketMessageModel messageToSend;

  const WebsocketSendMessageGatewayOutput({required this.messageToSend});

  @override
  List<Object?> get props => [messageToSend];
}

class WebsocketSendMessageSuccessInput extends SuccessInput {}
