import 'package:clean_framework/clean_framework.dart';

class ChatAssignee extends Equatable {
  final String assignee;
  final String assigneeImage;

  const ChatAssignee({this.assignee = '', this.assigneeImage = ''});

  factory ChatAssignee.fromJson(Map<String, dynamic> json) {
    return ChatAssignee(
        assignee: json['displayName'], assigneeImage: json['avatarUrl']);
  }

  @override
  List<Object?> get props => [assignee, assigneeImage];
}
