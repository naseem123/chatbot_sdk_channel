import 'package:chatbot/core/router/app_router.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
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
                data: data.copyWith(textScaleFactor: 1, boldText: false),
                child: child!,
              );
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
