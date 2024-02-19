import 'mesasge_ui_model.dart';

class SurveyInput extends ChatMessage {
  final String title;
  final String subtitle;
  final String buttonText;
  final Map<String, dynamic> surveyMap;

  const SurveyInput({
    this.title = '',
    this.subtitle = '',
    this.buttonText = '',
    this.surveyMap = const {},
  });

  factory SurveyInput.fromJson(List<dynamic> json,
      {required messageKey,
      required String conversationKey,
      required String appId,
      String? sessionId}) {
    final titleMap = json.firstWhere((element) => element['style'] == 'header',
        orElse: () => {});
    final subTitleMap = json.firstWhere(
        (element) => element['style'] == 'paragraph',
        orElse: () => {});
    final buttonMap = json.firstWhere((element) => element['type'] == 'button',
        orElse: () => {}) as Map<String, dynamic>;

    final surveyData = {
      'data': {
        'id': 'Surveys',
        'message_key': messageKey,
        'conversation_key': conversationKey,
        'enc_data': {},
        'app_id': appId,
        'session_id': sessionId,
        'field': {
          ...buttonMap,
          'values': {
            // while recieving we're getting in _ but sending we need to sent as camelCase
            "language": buttonMap['values']['language'],
            "senderId": buttonMap['values']['sender_id'],
            "templateTitle": buttonMap['values']['template_title'],
            "templateVersionId": buttonMap['values']['template_version_id'],
          }
        }
      }
    };

    return SurveyInput(
      title: titleMap['text'] ?? '',
      subtitle: subTitleMap['text'] ?? '',
      buttonText: buttonMap['label'] ?? '',
      surveyMap: surveyData,
    );
  }
}
