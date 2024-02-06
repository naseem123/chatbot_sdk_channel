import 'package:clean_framework/clean_framework.dart';
import 'package:equatable/equatable.dart';

class ChatDataItemModel1 extends Equatable {
  const ChatDataItemModel1({
    required this.title,
    required this.senderID,
    required this.time,
  });

  factory ChatDataItemModel1.fromJson(Map<String, dynamic> json) {
    final data = Deserializer(json);

    return ChatDataItemModel1(
      title: data.getString('title'),
      senderID: data.getString('senderID'),
      time: data.getString('time'),
    );
  }

  final String title;
  final String senderID;
  final String time;

  @override
  List<Object?> get props => [
        title,
        senderID,
        time,
      ];
}
