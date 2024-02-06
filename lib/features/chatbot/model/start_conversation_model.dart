import 'package:clean_framework/clean_framework.dart';

class StartConversationModel extends Equatable {
  final AppSettings app;

  const StartConversationModel({required this.app});

  factory StartConversationModel.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    final dataMessenger = Deserializer(data.getMap('messenger'));

    return StartConversationModel(
      app: AppSettings.fromJson(dataMessenger.getMap('app')),
    );
  }

  @override
  List<Object?> get props => [app];
}

class AppSettings extends Equatable {
  final NewConversationBotsSettings newConversationBots;

  const AppSettings({required this.newConversationBots});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return AppSettings(
      newConversationBots: NewConversationBotsSettings.fromJson(
          data.getMap('newConversationBots')),
    );
  }

  @override
  List<Object?> get props => [newConversationBots];
}

class NewConversationBotsSettings extends Equatable {
  final String id;
  final String name;
  final String? scheduledAt;
  final BotSettings settings;

  const NewConversationBotsSettings({
    required this.id,
    required this.name,
    required this.scheduledAt,
    required this.settings,
  });

  factory NewConversationBotsSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);

    return NewConversationBotsSettings(
      id: data.getString('id'),
      name: data.getString('name'),
      scheduledAt: data.getString('scheduled_at'),
      settings: BotSettings.fromJson(
        data.getMap('settings'),
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        scheduledAt,
        settings,
      ];
}

class BotSettings extends Equatable {
  final List<Path> paths;
  final String botType;
  final String scheduling;
  final String scheduleTrigger;
  final String scheduleTriggerHoliday;

  const BotSettings({
    required this.paths,
    required this.botType,
    required this.scheduling,
    required this.scheduleTrigger,
    required this.scheduleTriggerHoliday,
  });

  factory BotSettings.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);

    return BotSettings(
      paths: data.getList('paths', converter: Path.fromJson),
      botType: data.getString('bot_type'),
      scheduling: data.getString('scheduling'),
      scheduleTrigger: data.getString('schedule_trigger'),
      scheduleTriggerHoliday: data.getString('schedule_trigger_holiday'),
    );
  }

  @override
  List<Object?> get props => [
        paths,
        botType,
        scheduling,
        scheduleTrigger,
        scheduleTriggerHoliday,
      ];
}

class Path extends Equatable {
  final String id;
  final List<Step> steps;
  final String title;
  final List<FollowAction> followActions;

  const Path({
    required this.id,
    required this.steps,
    required this.title,
    required this.followActions,
  });

  factory Path.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);

    return Path(
      id: data.getString('id'),
      steps: data.getList('step', converter: Step.fromJson),
      title: data.getString('title'),
      followActions: data.getList('schema', converter: FollowAction.fromJson),
    );
  }

  @override
  List<Object?> get props => [
        id,
        steps,
        title,
        followActions,
      ];
}

class FollowAction extends Equatable {
  final String key;
  final String name;
  final String value;

  const FollowAction({
    required this.key,
    required this.name,
    required this.value,
  });

  factory FollowAction.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return FollowAction(
      key: data.getString('key'),
      name: data.getString('name'),
      value: data.getString('value'),
    );
  }

  @override
  List<Object?> get props => [
        key,
        name,
        value,
      ];
}

class Step extends Equatable {
  final String type;
  final Controls? controls;
  final List<dynamic> messages;
  final String stepUid;

  const Step({
    required this.type,
    this.controls,
    required this.messages,
    required this.stepUid,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);

    return Step(
      type: data.getString('type'),
      controls: Controls.fromJson(data.getMap('controls')),
      messages: json['messages'],
      stepUid: data.getString('step_uid'),
    );
  }

  @override
  List<Object?> get props => [
        type,
        controls,
        messages,
        stepUid,
      ];
}

class Controls extends Equatable {
  final String type;
  final List<Schema> schema;
  final bool? waitForInput;

  const Controls({
    required this.type,
    required this.schema,
    this.waitForInput,
  });

  factory Controls.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return Controls(
      type: data.getString('type'),
      schema: data.getList('schema', converter: Schema.fromJson),
      waitForInput: data.getBool('wait_for_input'),
    );
  }

  @override
  List<Object?> get props => [type, schema, waitForInput];
}

class Schema extends Equatable {
  final String id;
  final String label;
  final String element;
  final String? pathId;
  final String? nextStepUuid;

  const Schema({
    required this.id,
    required this.label,
    required this.element,
    this.pathId,
    this.nextStepUuid,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);
    return Schema(
      id: data.getString('id'),
      label: data.getString('label'),
      element: data.getString('element'),
      pathId: data.getString('path_id'),
      nextStepUuid: data.getString('next_step_uuid'),
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        element,
        pathId,
        nextStepUuid,
      ];
}
