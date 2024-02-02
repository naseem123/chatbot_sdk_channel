import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/dependency/graphql/api_gateway.dart';
import 'package:chatbot/features/chatbot/model/app_configuration_model.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:clean_framework_graphql/clean_framework_graphql.dart';

import 'configuration_request.dart';

class SDKConfigurationGateway extends APIGateway<ConfigurationGatewayOutput,
    SDKSettingConfigurationRequest, SDKConfigurationSuccessInput> {
  SDKConfigurationGateway({
    ProvidersContext? context,
    required UseCaseProvider useCaseProvider,
  }) : super(
          context: context ?? providersContext,
          provider: useCaseProvider,
        );

  @override
  SDKSettingConfigurationRequest buildRequest(
    ConfigurationGatewayOutput output,
  ) {
    return SDKSettingConfigurationRequest();
  }

  @override
  SDKConfigurationSuccessInput onSuccess(
    GraphQLSuccessResponse response,
  ) {
    return SDKConfigurationSuccessInput(
        appSettings: AppSettings.fromJson(response.data));
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    if (failureResponse is GraphQLFailureResponse) {
      return FailureInput(message: failureResponse.message);
    } else {
      return const FailureInput(
        message: 'Unknown Error',
      );
    }
  }
}

class ConfigurationGatewayOutput extends Output {
  const ConfigurationGatewayOutput();

  @override
  List<Object?> get props => [];
}

class SDKConfigurationSuccessInput extends SuccessInput {
  SDKConfigurationSuccessInput({required this.appSettings});

  final AppSettings appSettings;
}
