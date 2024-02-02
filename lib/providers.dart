import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/providers/src/api_providers.dart';
import 'package:chatbot/providers/src/usecase_providers.dart';
import 'package:riverpod/riverpod.dart';

import 'core/utils/shared_pref.dart';

final authTokenProvider = StateProvider<String>((_) => '');
final preferenceProvider = Provider<Preference>((_) => Preference());
late Preference preference;

void loadProviders() {
  chatBotUseCaseProvider.getUseCaseFromContext(providersContext);
  apiExternalInterfaceProvider.getExternalInterface(providersContext);
  preference = providersContext().read(preferenceProvider);
}
