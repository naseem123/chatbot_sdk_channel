import 'package:chatbot/core/dependency/webscoket/websocket_gateway.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class WebsocketMessageGateway extends WebsocketGateway<
    WebsocketMessageGatewayOutput,
    ListenToSocketRequest,
    WebsocketMessageSuccessInput> {
  WebsocketMessageGateway({
    required ProvidersContext context,
    required UseCaseProvider provider,
  }) : super(context: context, provider: provider);

  @override
  ListenToSocketRequest buildRequest(
    WebsocketMessageGatewayOutput output,
  ) {
    return ListenToSocketRequest();
  }

  @override
  WebsocketMessageSuccessInput onSuccess(
    WebsocketSuccessResponse response,
  ) {
    return WebsocketMessageSuccessInput(
      data: response.data,
    );
  }
}

class WebsocketMessageGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class WebsocketMessageSuccessInput extends SuccessInput {
  final Map<String, dynamic> data;

  WebsocketMessageSuccessInput({required this.data});
}
