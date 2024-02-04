import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

class ChatDetailsUIOutput extends Output {
  const ChatDetailsUIOutput({
    required this.chatDetailsUiState,
    required this.chatDetailList,
  });

  final ChatDetailsUiState chatDetailsUiState;
  final List<String> chatDetailList;

  @override
  List<Object?> get props => [
        chatDetailsUiState,
        chatDetailList,
      ];
}
