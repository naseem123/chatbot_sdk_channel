import 'package:clean_framework/clean_framework.dart';

class WebsocketMessageModel extends Equatable {
  final String conversationKey;
  final String messageKey;
  final String trigger;
  final String pathId;
  final String step;
  final Reply reply;
  final String action;

  const WebsocketMessageModel({
    required this.conversationKey,
    required this.messageKey,
    required this.trigger,
    required this.pathId,
    required this.step,
    required this.reply,
    required this.action,
  });

  factory WebsocketMessageModel.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return WebsocketMessageModel(
      conversationKey: data.getString('conversation_key'),
      messageKey: data.getString('message_key'),
      trigger: data.getString('trigger'),
      pathId: data.getString('path_id'),
      step: data.getString('step'),
      reply: Reply.fromJson(data.getMap('reply')),
      action: data.getString('action'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversation_key': conversationKey,
      'message_key': messageKey,
      'trigger': trigger,
      'path_id': pathId,
      'step': step,
      'reply': reply.toJson(),
      'action': action,
    };
  }

  @override
  List<Object?> get props => [
        conversationKey,
        messageKey,
        trigger,
        pathId,
        step,
        reply,
        action,
      ];
}

class Reply extends Equatable {
  final String element;
  final String id;
  final String label;
  final String nextStepUuid;
  final String pathId;

  const Reply({
    required this.element,
    required this.id,
    required this.label,
    required this.nextStepUuid,
    required this.pathId,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return Reply(
      element: data.getString('element'),
      id: data.getString('id'),
      label: data.getString('label'),
      nextStepUuid: data.getString('nextStepUuid'),
      pathId: data.getString('pathId'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'element': element,
      'id': id,
      'label': label,
      'nextStepUuid': nextStepUuid,
      'pathId': pathId,
    };
  }

  @override
  List<Object?> get props => [
        element,
        id,
        label,
        nextStepUuid,
        pathId,
      ];
}
