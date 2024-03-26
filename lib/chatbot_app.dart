import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/core/router/app_router.dart';
import 'package:chatbot/i18n/AppLocalizationsDelegate.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resources/resources.dart';

ProvidersContext get providersContext => _providersContext;

ProvidersContext _providersContext = ProvidersContext();

class ChatBotApp extends StatefulWidget {
  const ChatBotApp({super.key, this.testing = false});

  final bool testing;

  @override
  ChatBotAppState createState() => ChatBotAppState();
}

class ChatBotAppState extends State<ChatBotApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appRoute = providersContext().read(appRouterProvider);
    return AppTheme(
      brightness: Brightness.light,
      builder: (context) {
        return AppProvidersContainer(
          providersContext: providersContext,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                    textScaleFactor:
                        data.textScaleFactor > 2.0 ? 2.0 : data.textScaleFactor,
                    boldText: false),
                child: child!,
              );
            },
            locale: Locale(
                providersContext().read(envReaderProvider).getLang(), 'CA'),
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'CA'),
              Locale('fr', 'CA'),
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            title: 'ChatBot',
            theme: context.themeData,
            routeInformationParser: appRoute.routeInformationParser,
            routerDelegate: appRoute.routerDelegate,
            routeInformationProvider: appRoute.routeInformationProvider,
          ),
        );
      },
    );
  }
}
