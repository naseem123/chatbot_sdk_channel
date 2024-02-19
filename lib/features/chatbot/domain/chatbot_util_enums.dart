/// ChatBotUserState defines the user input state  in chat details page
enum ChatBotUserState {
  idle,
  waitForInput,
  survey,
  conversationClosed,
}

enum ChatMessageType {
  idle,
  askForInputButton,
  enterMessage,
  survey,
}

enum MessageSenderType {
  bot,
  user,
}

enum ChatSessionState { sessionActive, sessionUnavailable }

enum ReplyTimeState {
  auto,
  minutes,
  hours,
  day,
  off,
}

extension ReplyTimeStateExtension on ReplyTimeState {
  String get replyTimeText {
    switch (this) {
      case ReplyTimeState.auto:
        return "The team will respond as soon as possible";
      case ReplyTimeState.minutes:
        return "The team usually responds in minutes";
      case ReplyTimeState.hours:
        return "The team usually responds in a matter of hours";
      case ReplyTimeState.day:
        return "The team usually responds in one day";
      default:
        return "Don't display that";
    }
  }
}
