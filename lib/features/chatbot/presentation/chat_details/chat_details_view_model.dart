import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

class ChatDetailsViewModel extends ViewModel {
  const ChatDetailsViewModel({
    required this.uiState,
    required this.onMessageEntered,
    required this.chatList,
  });

  final ChatDetailsUiState uiState;
  final List<String> chatList;
  final Function(String message) onMessageEntered;

  @override
  List<Object?> get props => [
        uiState,
        chatList,
      ];
}
