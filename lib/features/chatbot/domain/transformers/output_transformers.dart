import 'package:chatbot/features/chatbot/domain/chat_details_ui_output.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_ui_output.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

class ChatBotUIOutputTransformer
    extends OutputTransformer<ChatBotEntity, ChatBotUIOutput> {
  @override
  ChatBotUIOutput transform(ChatBotEntity entity) {
    return ChatBotUIOutput(
        chatBotUiState: entity.chatBotUiState,
        chatList: entity.chatList?.conversations ?? [],
        appSettings: entity.appSettings,
        outBondUiState: entity.outBondUiState);
  }
}

class ChatDetailsUIOutputTransformer
    extends OutputTransformer<ChatBotEntity, ChatDetailsUIOutput> {
  @override
  ChatDetailsUIOutput transform(ChatBotEntity entity) {
    return ChatDetailsUIOutput(
      chatDetailsUiState: entity.chatDetailsUiState,
      chatDetailList: entity.chatDetailList,
      chatBotUserState: entity.chatBotUserState,
      chatMessageType: entity.chatMessageType,
      userInputOptions: entity.userInputOptions
          .where((element) => element.label.isNotEmpty)
          .toList(),
    );
  }
}
