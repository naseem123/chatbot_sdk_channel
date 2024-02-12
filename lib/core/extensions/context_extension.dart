import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  EdgeInsets get bottomPadding => MediaQuery.of(this).padding;
}
