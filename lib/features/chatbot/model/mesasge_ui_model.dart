import 'package:clean_framework/clean_framework.dart';

class MessageUiModel extends Equatable{

  final String message;
  final String messageId;

  const MessageUiModel({required this.message, required this.messageId});

  @override
  List<Object?> get props => [message, messageId,];

}