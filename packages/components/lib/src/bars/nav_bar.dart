import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import 'nav_bar_action.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
    this.title,
    this.bottom,
    this.hasDivider = false,
    this.actions,
    this.leading,
    this.leadingWidth,
  });

  const factory NavBar.high({
    Key? key,
    Widget? title,
    List<NavBarAction>? actions,
    NavBarAction? leading,
  }) = _HighNavBar;

  final Widget? title;
  final PreferredSizeWidget? bottom;
  final bool hasDivider;
  final List<NavBarAction>? actions;
  final NavBarAction? leading;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ?? const NavBarAction.back(),
      leadingWidth: leadingWidth ?? 56,
      title: title,
      bottom: _bottom,
      actions: actions,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(
      kToolbarHeight + (_bottom?.preferredSize.height ?? 0),
    );
  }

  PreferredSizeWidget? get _bottom {
    if (hasDivider) {
      Widget child = const Divider(height: 0, thickness: 1);
      var size = const Size.fromHeight(1);

      if (bottom != null) {
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            bottom!,
            child,
          ],
        );
        size += Offset(0, bottom!.preferredSize.height);
      }

      return PreferredSize(
        preferredSize: size,
        child: child,
      );
    }

    return bottom;
  }
}

class _HighNavBar extends NavBar {
  const _HighNavBar({
    super.key,
    super.title,
    super.actions,
    super.leading,
  }) : super(hasDivider: false);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ?? const NavBarAction.back(),
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: DefaultTextStyle(
              style: context.textTheme.headline2!.copyWith(
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
              child: title ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
