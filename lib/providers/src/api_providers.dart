import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_external_interface.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/providers.dart';
import 'package:chatbot/providers/src/gateway_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

final apiExternalInterfaceProvider = ExternalInterfaceProvider(
  (_) => APIExternalInterface(
    link: providersContext().read(envReaderProvider).getBaseUrl(),
    token: GraphQLToken(
      builder: () {
        final authToken = providersContext().read(authTokenProvider);
        return 'Bearer $authToken';
      },
    ),
    gatewayConnections: [
      () => chatBotGatewayProvider.getGateway(providersContext),
      () => configurationGatewayProvider.getGateway(providersContext),
    ],
  ),
);
