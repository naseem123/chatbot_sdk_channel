import 'package:chatbot/core/router/named_route.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_ui.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final isSocialLoginRedirect = state.location.startsWith('/signupIntro') &&
          state.queryParams.containsKey('code') &&
          state.queryParams.containsKey('state');
      if (isSocialLoginRedirect) {
        return '/socialLoginChooseRole';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: '/home',
        name: home,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ChatBotUI(
            key: state.pageKey,
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: '/chatDetail',
        name: chatDetail,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ChatDetailsUI(
            key: state.pageKey,
            conversationID: state.params['conversationId'] ?? "",
          ),
        ),
      )
    ],
    errorBuilder: (context, state) => _PageNotFound(
      key: state.pageKey,
    ),
  );
});

class _PageNotFound extends StatelessWidget {
  const _PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('404, Page Not Found!')));
  }
}
