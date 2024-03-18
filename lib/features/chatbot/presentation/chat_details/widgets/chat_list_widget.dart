import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _listScrollController.addListener(_scrollListener);
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
    return AnimatedList(
      reverse: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      key: _listKey,
      controller: _listScrollController,
      initialItemCount: widget.messages.length,
      itemBuilder: (context, index, animation) {
        return _buildItem(widget.messages[index], animation);
      },
    );
  }

  Widget _buildItem(ChatMessage message, Animation<double> animation) {
    Widget child;
    if (message is MessageUiModel) {
      child = MessageItemWidget(
        message: message,
        secondaryColor: widget.secondaryColor,
      );
    } else if (message is SurveyMessage) {
      child = SurveyWidget(
        surveyModel: message,
        primaryColor: widget.colorPrimary,
        onSurveyStartClicked: (surveyMap) {
          context
              .push('/survey', extra: {'surveyData': surveyMap}).then((value) {
            if (value != null && value is Map) {
              widget.onSurveyStartClicked(value);
            }
          });
        },
      );
    } else {
      child = const SizedBox.shrink();
    }
    return ScaleTransition(
      scale: CurvedAnimation(
        curve: Curves.fastEaseInToSlowEaseOut,
        parent: animation,
      ),
      child: child,
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

  @override
  void didUpdateWidget(covariant ChatListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      final difference = widget.messages.length - oldWidget.messages.length;
      if (difference == 1) {
        final messageFirst = widget.messages.first;
        if (messageFirst is MessageUiModel) {
          if (messageFirst.messageSenderType == MessageSenderType.user) {
            _listKey.currentState
                ?.insertItem(0, duration: const Duration(milliseconds: 100));
          } else {
            _listKey.currentState
                ?.insertItem(0, duration: const Duration(milliseconds: 450));
          }
        } else {
          _listKey.currentState
              ?.insertItem(0, duration: const Duration(milliseconds: 450));
        }
        scrollToLast();
      } else {
        _listKey.currentState?.insertAllItems(
            oldWidget.messages.length - 1, difference,
            duration: const Duration(milliseconds: 0));
      }
    }
  }
}
