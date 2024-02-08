import 'package:chatbot/features/chatbot/model/app_settings_model.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

class ChatBotUIOutput extends Output {
  final ChatBotUiState chatBotUiState;
  final OutBondUiState outBondUiState;
  final List<Conversation> chatList;
  final AppSettings appSettings;

  const ChatBotUIOutput({
    required this.chatBotUiState,
    required this.chatList,
    required this.outBondUiState,
    required this.appSettings,
  });

  @override
  List<Object?> get props => [
        chatBotUiState,
        chatList,
        appSettings,
        outBondUiState,
      ];
}
