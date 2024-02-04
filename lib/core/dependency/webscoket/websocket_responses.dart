import 'package:clean_framework/clean_framework.dart';

class WebsocketSuccessResponse extends SuccessResponse {
  final dynamic data;

  const WebsocketSuccessResponse({required this.data});

  factory WebsocketSuccessResponse.empty() {
    return const WebsocketSuccessResponse(data: "");
  }
}

class WebsocketFailureResponse
    extends TypedFailureResponse<WebsocketFailureType> {
  const WebsocketFailureResponse({
    required super.type,
    super.message,
    this.suggestion = '',
    Map<String, Object> super.errorData = const {},
  });

  final String suggestion;
}

enum WebsocketFailureType {
  unAuthenticated,
}
