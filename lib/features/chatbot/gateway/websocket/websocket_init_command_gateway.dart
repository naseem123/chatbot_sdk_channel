import 'dart:convert';
import 'package:chatbot/core/dependency/webscoket/websocket_gateway.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_send_message_gateway.dart';
import 'package:chatbot/features/chatbot/model/websocket/init_command_model.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class WebsocketInitCommandGateway extends WebsocketGateway<
    WebsocketInitCommandGatewayOutput,
    SendMessageToSocketRequest,
    WebsocketSendMessageSuccessInput> {
  WebsocketInitCommandGateway({
    required ProvidersContext context,
    required UseCaseProvider provider,
  }) : super(context: context, provider: provider);

  @override
  SendMessageToSocketRequest buildRequest(
    WebsocketInitCommandGatewayOutput output,
  ) {
    return SendMessageToSocketRequest(
        messageData: jsonEncode(output.messageToSend.toJson()));
  }

  @override
  WebsocketSendMessageSuccessInput onSuccess(
    WebsocketSuccessResponse response,
  ) {
    return WebsocketSendMessageSuccessInput();
  }
}

class WebsocketInitCommandGatewayOutput extends Output {
  final InitCommandModel messageToSend;

  const WebsocketInitCommandGatewayOutput({required this.messageToSend});

  @override
  List<Object?> get props => [messageToSend];
}
