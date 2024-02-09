import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/model/app_settings_model.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

class ChatDetailsUIOutput extends Output {
  const ChatDetailsUIOutput({
    required this.chatDetailsUiState,
    required this.chatDetailList,
    required this.chatBotUserState,
    required this.chatMessageType,
    required this.userInputOptions,
    required this.appSettings,
  });

  final ChatDetailsUiState chatDetailsUiState;
  final List<MessageUiModel> chatDetailList;
  final AppSettings appSettings;

  final ChatBotUserState chatBotUserState;
  final ChatMessageType chatMessageType;
  final List<Block> userInputOptions;

  @override
  List<Object?> get props => [
        chatDetailsUiState,
        chatDetailList,
        chatBotUserState,
        chatMessageType,
        userInputOptions,
    appSettings,
      ];
}
