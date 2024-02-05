import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_external_interface.dart';
import 'package:chatbot/core/dependency/webscoket/websocket_external_interface.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/providers/src/gateway_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

final apiExternalInterfaceProvider = ExternalInterfaceProvider(
  (_) => APIExternalInterface(
    link: providersContext().read(envReaderProvider).getBaseUrl(),
    gatewayConnections: [
      () => chatBotGatewayProvider.getGateway(providersContext),
      () => configurationGatewayProvider.getGateway(providersContext),
      () => chatDetailsGatewayProvider.getGateway(providersContext),
    ],
  ),
);

final websocketExternalInterfaceProvider = ExternalInterfaceProvider(
  (_) => WebsocketExternalInterface(
    link: providersContext().read(envReaderProvider).getWebsocketBaseUrl(),
    gatewayConnections: [
      () => connectWebsocketGatewayProvider.getGateway(providersContext),
      () => listenWebsocketGatewayProvider.getGateway(providersContext),
      () => sendWebsocketGatewayProvider.getGateway(providersContext),
    ],
  ),
);
