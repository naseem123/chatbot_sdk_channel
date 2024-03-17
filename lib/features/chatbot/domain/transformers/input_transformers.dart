import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/core/utils/shared_pref.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_connect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_disconnect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_message_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_send_message_gateway.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/chat_assignee.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/model/survey_input.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:chatbot/providers.dart';
import 'package:chatbot/providers/src/usecase_providers.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:collection/collection.dart';

class ChatDetailsDisconnectMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketDisconnectSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketDisconnectSuccessInput input) {
    return entity;
  }
}

class ChatDetailsGetMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketMessageSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketMessageSuccessInput input) {

    if (input.data["type"] == "conversations:typing"){
      Future.delayed(const Duration(milliseconds: 50), () {
        chatBotUseCaseProvider
            .getUseCaseFromContext(providersContext)
            .toggleAgentTypingStatus();
      });
      return entity;
    }
    else if (input.data["type"] == "confirm_subscription") {
      Future.delayed(const Duration(milliseconds: 50), () {
        chatBotUseCaseProvider
            .getUseCaseFromContext(providersContext)
            .initWebsocketConversation();
      });
      return entity;
    } else if (input.data["type"] == "triggers:receive") {
      final String triggerId =
          input.data.containsKey("data") && input.data["data"] != null
              ? input.data["data"]["trigger"]["id"]
              : "";
      return entity.merge(
        chatTriggerId: triggerId,
        chatBotUiState:
            triggerId.isNotEmpty ? ChatBotUiState.triggerReceived : null,
      );
    } else if (input.data["type"] == "conversations:update_state" &&
        input.data['data']['state'] == 'closed') {
      return entity.merge(
        chatBotUserState: ChatBotUserState.conversationClosed,
      );
    } else if (input.data["type"] == "conversations:update_state" &&
        (input.data['data'] as Map).containsKey("assignee") &&
        input.data['data']["assignee"]["display_name"] != null) {
      final assigneeMap = input.data['data']["assignee"];
      final assignee = ChatAssignee(
          assignee: assigneeMap["display_name"],
          assigneeImage: assigneeMap["avatar_url"]);
      return entity = entity.merge(chatAssignee: assignee);
    } else if (input.data["type"] == "conversations:conversation_part") {

      final conversationKey = input.data["data"]["conversation_key"];
      final messageKey = input.data["data"]["key"];
      Map<String, dynamic> messageData = input.data["data"]["message"];

      if (messageData.containsKey("blocks") &&
          messageData["blocks"]["type"] != null &&
          messageData["blocks"]["type"] != null &&
          messageData["blocks"]["type"] == "wait_for_reply") {
        return entity.merge(
          conversationKey: conversationKey,
          messageKey: messageKey,
          chatBotUserState: ChatBotUserState.waitForInput,
          chatMessageType: ChatMessageType.enterMessageAndTrigger,
          chatTriggerId: input.data["data"]["trigger_id"],
          chatStepId: input.data["data"]["step_id"],
          chatNextStepUUID: messageData["next_step_uuid"],
          chatPathId: messageData["path_id"],
        );
      } else if (messageData.containsKey("blocks") &&
          messageData["blocks"]["type"] != null &&
          messageData["blocks"]["type"] == "app_package" &&
          messageData["blocks"]["app_package"] == "Surveys") {
        String? sessionId = preference.get<String>(PreferenceKey.sessionId, "");
        final appId = providersContext().read(envReaderProvider).getAppID();

        final surveyMessage = SurveyMessage.fromJson(
          messageData["blocks"]["schema"],
          messageKey: messageKey,
          conversationKey: conversationKey,
          appId: appId,
          sessionId: sessionId,
        );

        // remove previous survey start text
        final currentChatList = List.of(entity.chatDetailList);

        if (messageKey == entity.messageKey) {
          final itemIdx = currentChatList.indexWhere(
            (element) => element.messageId == messageKey,
          );

          if (itemIdx != -1) {
            currentChatList[itemIdx] = surveyMessage;
            return entity.merge(chatDetailList: currentChatList);
          }
        }

        return entity.merge(
          conversationKey: conversationKey,
          messageKey: messageKey,
          chatBotUserState: ChatBotUserState.survey,
          chatMessageType: ChatMessageType.survey,
          chatDetailList: [surveyMessage, ...currentChatList],
        );
      } else {
        chatBotUseCaseProvider
            .getUseCaseFromContext(providersContext)
            .getNextConversationMessage(
              conversationKey: conversationKey,
              messageKey: messageKey,
            );
        var message = "";
        if (messageData.containsKey("blocks")) {
          final blockData = BlocksData.fromJson(messageData["blocks"]);

          final assigneeMap = input.data["data"]["app_user"];
          final assignee = ChatAssignee(
              assignee: assigneeMap["display_name"],
              assigneeImage: assigneeMap["avatar_url"]);
          if (assigneeMap["kind"] != "lead") {
            entity = entity.merge(chatAssignee: assignee);
          }

          final isSameAPreviousInputs = const IterableEquality()
              .equals(blockData.schema, entity.userInputOptions);

          if (blockData.label != null && blockData.label!.isNotEmpty) {
            final messageuiData = MessageUiModel(
                message: blockData.label!,
                messageId: messageData["id"].toString(),
                imageUrl: input.data["data"]["app_user"]["avatar_url"],
                messageSenderType:
                    input.data["data"]["app_user"]['kind'] == 'agent'
                        ? MessageSenderType.bot
                        : MessageSenderType.user,
                messageType: MessageType.normalText);

            if (!entity.chatDetailList.contains(messageuiData)) {
              if(messageuiData.messageSenderType != MessageSenderType.user) {
                Future.delayed(const Duration(milliseconds: 5), () {
                  chatBotUseCaseProvider
                      .getUseCaseFromContext(providersContext)
                      .toggleAgentTypingStatus();
                });
              }
              chatBotUseCaseProvider
                  .getUseCaseFromContext(providersContext)
                  .updateEntityAfterDelay(conversationKey: conversationKey,
                  messageKey: messageKey,
                  chatDetailList: [
                    messageuiData,
                    ...entity.chatDetailList,
                  ]);
            }
          }
          if (blockData.waitForInput && !isSameAPreviousInputs) {
            Future.delayed(const Duration(milliseconds: 5), () {
              chatBotUseCaseProvider
                  .getUseCaseFromContext(providersContext)
                  .toggleAgentTypingStatus();
            });
            chatBotUseCaseProvider
                .getUseCaseFromContext(providersContext).updateInputTypeAfterDelay(
              conversationKey: conversationKey,
              messageKey: messageKey,
              userInputOptions: blockData.schema,
              chatBotUserState: ChatBotUserState.waitForInput,
              chatMessageType: ChatMessageType.askForInputButton,
            );

            return entity;
          }
        } else {
          message = "";
          if (messageData["html_content"] != null &&
              messageData["html_content"] != "--***--") {
            message = messageData["html_content"];
          } else if (messageData["serialized_content"] != null &&
              messageData["serialized_content"] != "--***--") {
            message = messageData["serialized_content"];
          } else if (messageData["text_content"] != null &&
              messageData["text_content"] != "--***--") {
            message = messageData["text_content"];
          } else if (messageData.containsKey("action") &&
              messageData["action"] == "assigned") {
            message = "Assigned to ${messageData["data"]["name"]}";
            entity = entity.merge(
                chatBotUserState: ChatBotUserState.waitForInput,
                chatMessageType: ChatMessageType.enterMessage);
          }

          if (messageData.containsKey("action") &&
              messageData["action"] == "assigned") {
          } else {
            final assigneeMap = input.data["data"]["app_user"];
            final assignee = ChatAssignee(
                assignee: assigneeMap["display_name"],
                assigneeImage: assigneeMap["avatar_url"]);
            if (assigneeMap["kind"] != "lead") {
              entity = entity.merge(chatAssignee: assignee);
            }
          }
          final messageuiData = MessageUiModel(
            message: message,
            messageId: messageKey,
            imageUrl: input.data["data"]["app_user"]["avatar_url"],
            messageSenderType: input.data["data"]["app_user"]['kind'] == 'agent'
                ? MessageSenderType.bot
                : MessageSenderType.user,
          );
          if (!entity.chatDetailList.contains(messageuiData)) {
            if(messageuiData.messageSenderType != MessageSenderType.user){
            Future.delayed(const Duration(milliseconds: 5), () {
              chatBotUseCaseProvider
                  .getUseCaseFromContext(providersContext)
                  .toggleAgentTypingStatus();
            });
            }
            chatBotUseCaseProvider
                .getUseCaseFromContext(providersContext)
                .updateEntityAfterDelay(conversationKey: conversationKey,
                messageKey: messageKey,
                chatDetailList: [
                  messageuiData,
                  ...entity.chatDetailList,
                ]);
            return entity;
          }
          if (messageData['data'] != null &&
              (messageData['data'] as Map).containsKey('next_step_uuid') &&
              messageData['data']['next_step_uuid'] == null) {
            return entity.merge(
                chatBotUserState: ChatBotUserState.waitForInput,
                chatMessageType: ChatMessageType.enterMessage);
          }
        }
      }
      return entity;
    } else {
      return entity;
    }
  }
}

class ChatDetailsSendMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketSendMessageSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketSendMessageSuccessInput input) {
    return entity;
  }
}

class ChatDetailsConnectMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketConnectSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketConnectSuccessInput input) {
    return entity;
  }
}

class ChatDetailsUIInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketConnectSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketConnectSuccessInput input) {
    return entity;
  }
}
