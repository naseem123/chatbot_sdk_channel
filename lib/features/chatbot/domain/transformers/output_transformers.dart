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
      chatList: entity.chatList,
      appSettings: entity.appSettings,
      outBondUiState: entity.outBondUiState,
      idleTimeout: entity.idleTimeout,
      conversationsListUiState: entity.conversationsListUiState,
      isInboundEnabled: entity.appSettings.app.inboundSettings.enabled,
    );
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
      appSettings: entity.appSettings,
      chatAssignee: entity.chatAssignee,
      idleTimeout: entity.idleTimeout,
      chatSessionState: entity.chatSessionState,
      totalPages: entity.totalPages,
      currentPage: entity.currentPage,
      isAgentTyping: entity.isAgentTyping,
    );
  }
}
