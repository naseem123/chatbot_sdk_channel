enum ChatBotUserState {
  idle,
  waitForInput,
  conversationClosed,
}

enum ChatMessageType {
  idle,
  askForInputButton,
  enterMessage,
}

enum MessageSenderType {
  bot,
  user,
}
