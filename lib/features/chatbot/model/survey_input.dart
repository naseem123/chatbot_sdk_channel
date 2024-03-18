import 'dart:convert';

import 'mesasge_ui_model.dart';

class SurveyMessage extends ChatMessage {
  final List<SurveyMessage> children;

  const SurveyMessage(
      {super.messageType, this.children = const [], super.messageId});

  static SurveyMessage fromJson(
    List<dynamic> json, {
    required String messageKey,
    required String conversationKey,
    required String appId,
    required String baseUrl,
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
        final uncodedSurvey = Uri.encodeComponent(jsonEncode(surveyData));

        final url = '$baseUrl/package_iframe/surveys?data=$uncodedSurvey';

        messageArray.add(SurveyInputButton(
          messageType: MessageType.surveyMessage,
          label: e['label'],
          surveyEncodes: url,
        ));
      }
    }

    return SurveyMessage(
        children: messageArray,
        messageType: MessageType.surveyMessage,
        messageId: messageKey);
  }

  bool get isSurveyStartMsg =>
      children.whereType<SurveyInputButton>().isNotEmpty;

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
  final String surveyEncodes;

  const SurveyInputButton({
    super.messageType,
    required this.label,
    required this.surveyEncodes,
  });

  @override
  List<Object?> get props => [label, surveyEncodes];
}

enum InputType { text, button, divider }
