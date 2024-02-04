import 'package:chatbot/core/dependency/webscoket/websocket_requests.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_responses.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

abstract class WebsocketGateway<O extends Output, R extends WebsocketRequest,
        S extends SuccessInput>
    extends WatcherGateway<O, R, WebsocketSuccessResponse, S> {
  WebsocketGateway({
    required super.context,
    required super.provider,
  });

  @override
  FailureInput onFailure(WebsocketFailureResponse failureResponse) {
    return WebsocketFailureInput(
      type: failureResponse.type,
      message: failureResponse.message,
      suggestion: failureResponse.suggestion,
    );
  }
}

class WebsocketFailureInput extends FailureInput {
  WebsocketFailureInput({
    required this.type,
    super.message,
    this.suggestion = '',
  });

  final WebsocketFailureType type;
  final String suggestion;
}
