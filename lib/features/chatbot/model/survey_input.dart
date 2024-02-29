import 'mesasge_ui_model.dart';

class SurveyMessage extends ChatMessage {
  final List<SurveyMessage> children;

  const SurveyMessage({super.messageType, this.children = const []});

  static SurveyMessage fromJson(
    List<dynamic> json, {
    required String messageKey,
    required String conversationKey,
    required String appId,
    String? sessionId,
  }) {
    final messageArray = <SurveyMessage>[];

    for (var e in json) {
      if (e['type'] == 'separator') {
        messageArray.add(const SurveyInputSeparator(
          messageType: MessageType.surveyMessage,
        ));
      } else if (e['type'] == 'text') {
        messageArray.add(SurveyInputText(
          messageType: MessageType.surveyMessage,
          text: e['text'],
          style: e['style'],
          align: e['align'] ?? '',
        ));
      } else if (e['type'] == 'button') {
        final surveyData = {
          'data': {
            'id': 'Surveys',
            'message_key': messageKey,
            'conversation_key': conversationKey,
            'enc_data': {},
            'app_id': appId,
            'session_id': sessionId,
            'field': {
              ...e,
              'values': {
                // while recieving we're getting in "_" but sending we need to sent as camelCase
                "language": e['values']['language'],
                "senderId": e['values']['sender_id'],
                "templateTitle": e['values']['template_title'],
                "templateVersionId": e['values']['template_version_id'],
              }
            }
          }
        };

        messageArray.add(SurveyInputButton(
          messageType: MessageType.surveyMessage,
          label: e['label'],
          surveyData: surveyData,
        ));
      }
    }

    return SurveyMessage(
        children: messageArray, messageType: MessageType.surveyMessage);
  }

  bool get isSurveySubmit => children.whereType<SurveyInputButton>().isNotEmpty;

  @override
  List<Object?> get props => [children];
}

class SurveyInputText extends SurveyMessage {
  final String text;
  final String style;
  final String align;

  const SurveyInputText({
    super.messageType,
    required this.text,
    this.style = '',
    this.align = '',
  });

  @override
  List<Object?> get props => [text, style, align];
}

class SurveyInputSeparator extends SurveyMessage {
  const SurveyInputSeparator({
    super.messageType,
  });

  @override
  List<Object?> get props => [];
}

class SurveyInputButton extends SurveyMessage {
  final String label;
  final Map<String, dynamic> surveyData;

  const SurveyInputButton({
    super.messageType,
    required this.label,
    required this.surveyData,
  });

  @override
  List<Object?> get props => [label, surveyData];
}

enum InputType { text, button, divider }
