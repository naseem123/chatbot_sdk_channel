import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/configuration_gateway.dart';
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
