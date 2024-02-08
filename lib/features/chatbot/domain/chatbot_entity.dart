import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

import '../model/app_settings_model.dart';
import '../model/conversation_model.dart';

class ChatBotEntity extends Entity {
  final ChatBotUiState chatBotUiState;
  final OutBondUiState outBondUiState;
  final ChatConversationSuccessInput? chatList;
  final AppSettings appSettings;

  //Chat details fields
  final ChatDetailsUiState chatDetailsUiState;
  final List<MessageUiModel> chatDetailList;
  final ChatBotUserState chatBotUserState;
  final ChatMessageType chatMessageType;

  //Chat conversation fields
  final String chatTriggerId;
  final String conversationKey;
  final String messageKey;
  final List<Block> userInputOptions;

  const ChatBotEntity({
    this.chatBotUiState = ChatBotUiState.conversationLoading,
    this.outBondUiState = OutBondUiState.outBondStateIdle,
    this.chatList,
    this.appSettings = const AppSettings(),
    this.chatDetailsUiState = ChatDetailsUiState.idle,
    this.chatDetailList = const [],
    this.chatTriggerId = "",
    this.chatBotUserState = ChatBotUserState.idle,
    this.chatMessageType = ChatMessageType.idle,
    this.conversationKey = "",
    this.messageKey = "",
    this.userInputOptions = const [],
  });

  ChatBotEntity merge({
    ChatBotUiState? chatBotUiState,
    OutBondUiState? outBondUiState,
    ChatConversationSuccessInput? chatList,
    AppSettings? appSettings,
    ChatDetailsUiState? chatDetailsUiState,
    List<MessageUiModel>? chatDetailList,
    String? chatTriggerId,
    String? conversationKey,
    ChatBotUserState? chatBotUserState,
    ChatMessageType? chatMessageType,
    List<Block>? userInputOptions,
    String? messageKey,
  }) {
    return ChatBotEntity(
      chatBotUiState: chatBotUiState ?? this.chatBotUiState,
      chatList: chatList ?? this.chatList,
      appSettings: appSettings ?? this.appSettings,
      chatDetailsUiState: chatDetailsUiState ?? this.chatDetailsUiState,
      chatDetailList: chatDetailList ?? this.chatDetailList,
      chatTriggerId: chatTriggerId ?? this.chatTriggerId,
      conversationKey: conversationKey ?? this.conversationKey,
      messageKey: messageKey ?? this.messageKey,
      chatBotUserState: chatBotUserState ?? this.chatBotUserState,
      chatMessageType: chatMessageType ?? this.chatMessageType,
      userInputOptions: userInputOptions ?? this.userInputOptions,
      outBondUiState: outBondUiState ?? this.outBondUiState,
    );
  }

  @override
  List<Object?> get props => [
        chatBotUiState,
        outBondUiState,
        chatList,
        appSettings,
        chatDetailsUiState,
        chatDetailList,
        conversationKey,
        chatTriggerId,
        chatBotUserState,
        chatMessageType,
      ];
}
