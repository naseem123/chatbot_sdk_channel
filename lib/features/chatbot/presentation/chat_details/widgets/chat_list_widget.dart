import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/model/survey_input.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'survey_input_widget.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.messages,
    required this.secondaryColor,
    required this.colorPrimary,
    required this.loadMoreChats,
    required this.onSurveyStartClicked,
  });

  final int currentPage;
  final int totalPage;
  final List<ChatMessage> messages;
  final Color secondaryColor;
  final Color colorPrimary;
  final VoidCallback loadMoreChats;
  final void Function(Map) onSurveyStartClicked;

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget>
    with TickerProviderStateMixin {
  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listScrollController.addListener(_scrollListener);
    print("initState");
    scrollToLast();
  }

  void _scrollListener() {
    if (!_listScrollController.hasClients) return;
    double maxScroll = _listScrollController.position.maxScrollExtent;
    double currentScroll = _listScrollController.position.pixels;
    double thresholdScroll = 50;
    bool isScrollNearingEndOfList =
        (maxScroll - currentScroll) <= thresholdScroll;

    if (isScrollNearingEndOfList && widget.currentPage < widget.totalPage) {
      widget.loadMoreChats.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      itemCount: widget.messages.length,
      controller: _listScrollController,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        if (message is MessageUiModel) {
          return MessageItemWidget(
            message: message,
            secondaryColor: widget.secondaryColor,
          );
        } else if (message is SurveyMessage) {
          return SurveyWidget(
            surveyModel: message,
            primaryColor: widget.colorPrimary,
            onSurveyStartClicked: (surveyMap) {
              context.push('/survey', extra: {'surveyData': surveyMap}).then(
                  (value) {
                if (value != null && value is Map) {
                  widget.onSurveyStartClicked(value);
                }
              });
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void scrollToLast() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listScrollController.animateTo(
        _listScrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollController
      ..removeListener(_scrollListener)
      ..dispose();
  }
}
