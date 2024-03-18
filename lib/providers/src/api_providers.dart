import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_external_interface.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_external_interface.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/providers/src/gateway_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

final apiExternalInterfaceProvider = ExternalInterfaceProvider(
  (_) => APIExternalInterface(
    appId: providersContext().read(envReaderProvider).getAppID(),
    link: providersContext().read(envReaderProvider).getApiUrl(),
    origin: providersContext().read(envReaderProvider).getBaseUrl(),
    lang: providersContext().read(envReaderProvider).getLang(),
    gatewayConnections: [
      () => chatBotGatewayProvider.getGateway(providersContext),
      () => configurationGatewayProvider.getGateway(providersContext),
      () => initGuestUserGatewayProvider.getGateway(providersContext),
      () => startConversationGatewayProvider.getGateway(providersContext),
      () => conversationHistoryGatewayProvider.getGateway(providersContext),
      () => sendMessageGatewayProvider.getGateway(providersContext),
    ],
  ),
);

final websocketExternalInterfaceProvider = ExternalInterfaceProvider(
  (_) => WebsocketExternalInterface(
    appId: providersContext().read(envReaderProvider).getAppID(),
    baseURL: providersContext().read(envReaderProvider).getBaseUrl(),
    link: providersContext().read(envReaderProvider).getWebsocketBaseUrl(),
    gatewayConnections: [
      () => connectWebsocketGatewayProvider.getGateway(providersContext),
      () => listenWebsocketGatewayProvider.getGateway(providersContext),
      () => sendWebsocketGatewayProvider.getGateway(providersContext),
      () => disconnectWebsocketGatewayProvider.getGateway(providersContext),
      () => websocketInitCommandGatewayProvider.getGateway(providersContext),
    ],
  ),
);
