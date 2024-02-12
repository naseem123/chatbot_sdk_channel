class ChatAssignee {
  final String assignee;
  final String assigneeImage;

  const ChatAssignee({this.assignee = '', this.assigneeImage = ''});

  factory ChatAssignee.fromJson(Map<String, dynamic> json) {
    return ChatAssignee(
        assignee: json['displayName'], assigneeImage: json['avatarUrl']);
  }
}
