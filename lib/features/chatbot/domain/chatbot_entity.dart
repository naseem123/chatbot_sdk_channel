import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/chat_assignee.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

import '../model/app_settings_model.dart';
import '../model/conversation_model.dart';

class ChatBotEntity extends Entity {
  final ChatBotUiState chatBotUiState;
  final OutBondUiState outBondUiState;
  final ConversationMeta conversationMeta;
  final List<Conversation> chatList;
  final AppSettings appSettings;
  final ConversationsListUiState conversationsListUiState;

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
  final ChatAssignee chatAssignee;
  final int currentPage;
  final int totalPages;
  final ChatListUiState chatListUiState;

  // Chat session fields
  final ChatSessionState chatSessionState;
  final int idleTimeout;

  final String chatStepId;
  final String chatPathId;
  final String chatNextStepUUID;

  const ChatBotEntity({
    this.chatBotUiState = ChatBotUiState.conversationLoading,
    this.outBondUiState = OutBondUiState.outBondStateIdle,
    this.conversationsListUiState = ConversationsListUiState.idle,
    this.chatList = const [],
    this.conversationMeta = const ConversationMeta(),
    this.appSettings = const AppSettings(),
    this.chatDetailsUiState = ChatDetailsUiState.idle,
    this.chatDetailList = const [],
    this.chatTriggerId = "",
    this.chatBotUserState = ChatBotUserState.idle,
    this.chatMessageType = ChatMessageType.idle,
    this.conversationKey = "",
    this.messageKey = "",
    this.userInputOptions = const [],
    this.chatAssignee = const ChatAssignee(),
    this.chatSessionState = ChatSessionState.sessionUnavailable,
    this.idleTimeout = 10,
    this.currentPage = 1,
    this.totalPages = 1,
    this.chatListUiState = ChatListUiState.idle,
    this.chatStepId = "",
    this.chatPathId = "",
    this.chatNextStepUUID = "",
  });

  ChatBotEntity merge({
    ChatBotUiState? chatBotUiState,
    OutBondUiState? outBondUiState,
    ConversationsListUiState? conversationsListUiState,
    List<Conversation>? chatList,
    ConversationMeta? conversationMeta,
    AppSettings? appSettings,
    ChatDetailsUiState? chatDetailsUiState,
    List<MessageUiModel>? chatDetailList,
    String? chatTriggerId,
    String? conversationKey,
    ChatBotUserState? chatBotUserState,
    ChatMessageType? chatMessageType,
    List<Block>? userInputOptions,
    String? messageKey,
    ChatAssignee? chatAssignee,
    ChatSessionState? chatSessionState,
    int? idleTimeout,
    int? currentPage,
    int? totalPages,
    ChatListUiState? chatListUiState,
    String? chatStepId,
    String? chatPathId,
    String? chatNextStepUUID,
  }) {
    return ChatBotEntity(
      chatBotUiState: chatBotUiState ?? this.chatBotUiState,
      conversationsListUiState:
          conversationsListUiState ?? this.conversationsListUiState,
      chatList: chatList ?? this.chatList,
      conversationMeta: conversationMeta ?? this.conversationMeta,
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
      chatAssignee: chatAssignee ?? this.chatAssignee,
      chatSessionState: chatSessionState ?? this.chatSessionState,
      idleTimeout: idleTimeout ?? this.idleTimeout,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      chatListUiState: chatListUiState ?? this.chatListUiState,
      chatStepId: chatStepId ?? this.chatStepId,
      chatPathId: chatPathId ?? this.chatPathId,
      chatNextStepUUID: chatNextStepUUID ?? this.chatNextStepUUID,
    );
  }

  @override
  List<Object?> get props => [
        chatBotUiState,
        outBondUiState,
        conversationsListUiState,
        chatList,
        appSettings,
        chatDetailsUiState,
        chatDetailList,
        conversationKey,
        chatTriggerId,
        chatBotUserState,
        chatMessageType,
        userInputOptions,
        chatSessionState,
        idleTimeout,
        chatAssignee,
        messageKey,
        conversationMeta,
        chatListUiState,
        chatStepId,
        chatPathId,
        chatNextStepUUID,
      ];
}
