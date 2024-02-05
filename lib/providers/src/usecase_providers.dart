import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_use_case.dart';
import 'package:clean_framework/clean_framework_legacy.dart';

final chatBotUseCaseProvider = UseCaseProvider<ChatBotEntity, ChatBotUseCase>(
  (_) => ChatBotUseCase(),
);

final chatDetailsUseCaseProvider =
    UseCaseProvider<ChatBotEntity, ChatBotUseCase>(
  (_) => ChatBotUseCase(),
);
