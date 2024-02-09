import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/configuration_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/conversation_history_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/init_guest_user_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/start_conversation_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_connect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_disconnect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_init_command_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_message_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_send_message_gateway.dart';
import 'package:chatbot/providers/src/usecase_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

final chatBotGatewayProvider = GatewayProvider(
  (_) => ChatBotGateway(
    context: providersContext,
    useCaseProvider: chatBotUseCaseProvider,
  ),
);

final configurationGatewayProvider = GatewayProvider(
  (_) => SDKConfigurationGateway(
    context: providersContext,
    useCaseProvider: chatBotUseCaseProvider,
  ),
);

final initGuestUserGatewayProvider = GatewayProvider(
  (_) => InitGuestUserGateway(
    context: providersContext,
    useCaseProvider: chatBotUseCaseProvider,
  ),
);

final startConversationGatewayProvider = GatewayProvider(
  (_) => StartConversationGateway(
    context: providersContext,
    useCaseProvider: chatBotUseCaseProvider,
  ),
);

final conversationHistoryGatewayProvider = GatewayProvider(
  (_) => ConversationHistoryGateway(
    context: providersContext,
    useCaseProvider: chatBotUseCaseProvider,
  ),
);

// region websocket connection gateways
final connectWebsocketGatewayProvider = GatewayProvider(
  (_) => WebsocketConnectGateway(
    context: providersContext,
    provider: chatBotUseCaseProvider,
  ),
);

final listenWebsocketGatewayProvider = GatewayProvider(
  (_) => WebsocketMessageGateway(
    context: providersContext,
    provider: chatBotUseCaseProvider,
  ),
);

final sendWebsocketGatewayProvider = GatewayProvider(
  (_) => WebsocketSendMessageGateway(
    context: providersContext,
    provider: chatBotUseCaseProvider,
  ),
);

final disconnectWebsocketGatewayProvider = GatewayProvider(
  (_) => WebsocketDisconnectGateway(
    context: providersContext,
    provider: chatBotUseCaseProvider,
  ),
);

final websocketInitCommandGatewayProvider = GatewayProvider(
  (_) => WebsocketInitCommandGateway(
    context: providersContext,
    provider: chatBotUseCaseProvider,
  ),
);
