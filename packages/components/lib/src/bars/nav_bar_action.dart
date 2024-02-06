import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resources/resources.dart';

enum NavBarIcons {
  chevronLeft,
  chevronDown,
  close,
}

class NavBarAction extends StatelessWidget {
  const NavBarAction({
    super.key,
    required this.child,
  });

  const factory NavBarAction.back({
    Key? key,
    VoidCallback? onPressed,
  }) = _BackNavBarAction;

  const factory NavBarAction.icon({
    Key? key,
    required NavBarIcons icon,
    required VoidCallback onPressed,
    Alignment alignment,
  }) = _IconNavBarAction;

  const factory NavBarAction.text({
    Key? key,
    required String label,
    required VoidCallback onPressed,
  }) = _TextNavBarAction;

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

const List<String> _navBarIcons = [
  'assets/icons/nav_chevron_left.svg',
  'assets/icons/nav_chevron_down.svg',
  'assets/icons/nav_close.svg'
];

class _IconNavBarAction extends NavBarAction {
  const _IconNavBarAction({
    super.key,
    required this.icon,
    required this.onPressed,
    this.alignment = Alignment.center,
  }) : super(child: const SizedBox.shrink());

  final NavBarIcons icon;
  final VoidCallback onPressed;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: alignment,
      icon: SvgPicture.asset(
        _navBarIcons[icon.index],
        package: 'resources',
        color: Theme.of(context).appBarTheme.iconTheme!.color,
      ),
      onPressed: onPressed,
    );
  }
}

class _TextNavBarAction extends NavBarAction {
  const _TextNavBarAction({
    super.key,
    required this.label,
    required this.onPressed,
  }) : super(child: const SizedBox.shrink());

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(40, 24),
            textStyle: context.textTheme.body1Regular,
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}

class _BackNavBarAction extends NavBarAction {
  const _BackNavBarAction({
    super.key,
    this.onPressed,
  }) : super(child: const SizedBox.shrink());

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _IconNavBarAction(
      icon: NavBarIcons.chevronLeft,
      alignment: const Alignment(-0.3, 0),
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }
}
