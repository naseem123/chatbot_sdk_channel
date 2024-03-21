import 'package:clean_framework/clean_framework.dart';

class Block extends Equatable {
  final String element;
  final String id;
  final String label;
  final String nextStepUuid;
  final String pathId;
  final List<Rule>? rules;

    const Block({
    required this.element,
    required this.id,
    required this.label,
    required this.nextStepUuid,
    required this.pathId,
    this.rules,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'element': element,
      'id': id,
      'label': label,
      'next_step_uuid': nextStepUuid,
      'path_id': pathId,
    };
    return data;
  }

  @override
  List<Object?> get props => [element, id, label, nextStepUuid, pathId, rules];
}

class BlockInput extends Equatable {
  final String label;
  final String nextStepUuid;
  final String pathId;
  final String htmlContent;
  final String serializedContent;
  final String textContent;

  const BlockInput({
    required this.label,
    required this.nextStepUuid,
    required this.pathId,
    required this.htmlContent,
    required this.serializedContent,
    required this.textContent,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'label': label,
      'nextStepUuid': nextStepUuid,
      'pathId': pathId,
      "html_content": htmlContent,
      "serialized_content": serializedContent,
      "text_content": textContent,
    };
    return data;
  }

  @override
  List<Object?> get props => [
        label,
        nextStepUuid,
        pathId,
        htmlContent,
        serializedContent,
        textContent
      ];
}

class Rule extends Equatable {
  final String action;
  final String attribute;
  final String target;
  final List<String> value;

  const Rule({
    required this.action,
    required this.attribute,
    required this.target,
    required this.value,
  });

  @override
  List<Object?> get props => [action, attribute, target, value];
}

class BlocksData extends Equatable {
  final List<Block> schema;
  final String type;
  final bool waitForInput;
  final String? label;

  const BlocksData({
    required this.schema,
    required this.type,
    required this.waitForInput,
    this.label,
  });

  @override
  List<Object?> get props => [schema, type, waitForInput];

  bool get waitForReply => type == 'wait_for_reply';
  bool get askForInput => type == 'ask_option';

  factory BlocksData.fromJson(Map<String, dynamic> json) {
    List<dynamic> schemaList = json['schema'];
    List<Block> schema = schemaList
        .map((e) => Block(
              element: e['element'] ?? "",
              id: e['id'] ?? "",
              label: e['label'] ?? "",
              nextStepUuid: e['next_step_uuid'] ?? "",
              pathId: e['path_id'] ?? "",
              rules: e['rules'] != null
                  ? (e['rules'] as List).map((r) {
                      return Rule(
                        action: r['action'],
                        attribute: r['attribute'],
                        target: r['target'],
                        value: (r['value'] as List).cast<String>(),
                      );
                    }).toList()
                  : null,
            ))
        .toList();

    return BlocksData(
        schema: schema,
        type: json['type'],
        waitForInput: json['wait_for_input'] ?? true,
        label: json['label'] ?? "");
  }
}
