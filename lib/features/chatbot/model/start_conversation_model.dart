import 'package:equatable/equatable.dart';

class MessengerSettings extends Equatable {
  final AppSettings app;

  MessengerSettings({required this.app});

  factory MessengerSettings.fromJson(Map<String, dynamic> json) {
    return MessengerSettings(
      app: AppSettings.fromJson(json['messenger']['app']),
    );
  }

  @override
  List<Object?> get props => [app];
}

class AppSettings extends Equatable {
  final NewConversationBotsSettings newConversationBots;

  AppSettings({required this.newConversationBots});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      newConversationBots: NewConversationBotsSettings.fromJson(
          json['newConversationBots']),
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

  NewConversationBotsSettings(
      {required this.id,
        required this.name,
        required this.scheduledAt,
        required this.settings});

  factory NewConversationBotsSettings.fromJson(Map<String, dynamic> json) {
    return NewConversationBotsSettings(
      id: json['id'],
      name: json['name'],
      scheduledAt: json['scheduled_at'],
      settings: BotSettings.fromJson(json['settings']),
    );
  }

  @override
  List<Object?> get props => [id, name, scheduledAt, settings];
}

class BotSettings extends Equatable {
  final List<Path> paths;
  final String botType;
  final String scheduling;
  final String scheduleTrigger;
  final String scheduleTriggerHoliday;

  BotSettings(
      {required this.paths,
        required this.botType,
        required this.scheduling,
        required this.scheduleTrigger,
        required this.scheduleTriggerHoliday});

  factory BotSettings.fromJson(Map<String, dynamic> json) {
    return BotSettings(
      paths: (json['paths'] as List)
          .map((pathJson) => Path.fromJson(pathJson))
          .toList(),
      botType: json['bot_type'],
      scheduling: json['scheduling'],
      scheduleTrigger: json['schedule_trigger'],
      scheduleTriggerHoliday: json['schedule_trigger_holiday'],
    );
  }

  @override
  List<Object?> get props =>
      [paths, botType, scheduling, scheduleTrigger, scheduleTriggerHoliday];
}

class Path extends Equatable {
  final String id;
  final List<Step> steps;
  final String title;
  final List<dynamic>? followActions;

  Path({required this.id, required this.steps, required this.title, this.followActions});

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
      id: json['id'],
      steps: (json['steps'] as List)
          .map((stepJson) => Step.fromJson(stepJson))
          .toList(),
      title: json['title'],
      followActions: json['follow_actions'] as List?,
    );
  }

  @override
  List<Object?> get props => [id, steps, title, followActions];
}

class Step extends Equatable {
  final String type;
  final Controls? controls;
  final List<dynamic> messages;
  final String stepUid;

  Step({required this.type, this.controls, required this.messages, required this.stepUid});

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      type: json['type'],
      controls: json['controls'] != null ? Controls.fromJson(json['controls']) : null,
      messages: json['messages'],
      stepUid: json['step_uid'],
    );
  }

  @override
  List<Object?> get props => [type, controls, messages, stepUid];
}

class Controls extends Equatable {
  final String type;
  final List<Schema> schema;
  final bool? waitForInput;

  Controls({required this.type, required this.schema, this.waitForInput});

  factory Controls.fromJson(Map<String, dynamic> json) {
    return Controls(
      type: json['type'],
      schema: (json['schema'] as List)
          .map((schemaJson) => Schema.fromJson(schemaJson))
          .toList(),
      waitForInput: json['wait_for_input'],
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

  Schema({required this.id, required this.label, required this.element, this.pathId, this.nextStepUuid});

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
      id: json['id'],
      label: json['label'],
      element: json['element'],
      pathId: json['path_id'],
      nextStepUuid: json['next_step_uuid'],
    );
  }

  @override
  List<Object?> get props => [id, label, element, pathId, nextStepUuid];
}
