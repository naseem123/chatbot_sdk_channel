import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_connect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_disconnect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_message_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_send_message_gateway.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
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
    if (input.data["type"] == "triggers:receive") {
      final triggerId = input.data["data"]["trigger"]["id"];
      Future.delayed(const Duration(milliseconds: 300), () {
        chatBotUseCaseProvider
            .getUseCaseFromContext(providersContext)
            .initWebsocketCommand(chatTriggerId: triggerId);

        Future.delayed(const Duration(milliseconds: 2000), () {
          chatBotUseCaseProvider
              .getUseCaseFromContext(providersContext)
              .loadRecentConversationList(page: 1, perPage: 100);
        });
      });

      return entity.merge(chatTriggerId: triggerId);
    } else if (input.data["type"] == "conversations:update_state") {
      return entity.merge(
        chatBotUserState: ChatBotUserState.conversationClosed,
      );
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
          chatMessageType: ChatMessageType.enterMessage,
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

          final isSameAPreviousInput = const IterableEquality()
              .equals(blockData.schema, entity.userInputOptions);
          print(
              'ChatDetailsGetMessageInputTransformer.transform ${isSameAPreviousInput}');

          if (blockData.label != null && blockData.label!.isNotEmpty) {
            final messageuiData = MessageUiModel(
              message: blockData.label!,
              messageId: messageData["id"].toString(),
              imageUrl: input.data["data"]["app_user"]["avatar_url"],
              messageSenderType: MessageSenderType.bot,
            );
            if (!entity.chatDetailList.contains(messageuiData)) {
              entity = entity.merge(
                  conversationKey: conversationKey,
                  messageKey: messageKey,
                  chatDetailList: [...entity.chatDetailList, messageuiData]);
            }
          }
          if (blockData.waitForInput && !isSameAPreviousInput) {
            return entity.merge(
              conversationKey: conversationKey,
              messageKey: messageKey,
              userInputOptions: blockData.schema,
              chatBotUserState: ChatBotUserState.waitForInput,
              chatMessageType: ChatMessageType.askForInputButton,
            );
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
          final messageuiData = MessageUiModel(
            message: message,
            messageId: messageKey,
            imageUrl: input.data["data"]["app_user"]["avatar_url"],
            messageSenderType: MessageSenderType.bot,
          );
          if (!entity.chatDetailList.contains(messageuiData)) {
            return entity.merge(
                conversationKey: conversationKey,
                messageKey: messageKey,
                chatDetailList: [...entity.chatDetailList, messageuiData]);
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
