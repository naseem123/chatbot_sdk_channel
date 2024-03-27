import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resources/resources.dart';

enum BannerMode { normal, info, error }

const Map<BannerMode, String> _bannerAssets = {
  BannerMode.info: 'assets/icons/banner_info.svg',
  BannerMode.error: 'assets/icons/warning.svg'
};

class FlatBanner extends StatelessWidget {
  const FlatBanner({
    super.key,
    required this.child,
    this.mode = BannerMode.info,
    this.action,
    this.actionAlignment = Alignment.centerLeft,
  });

  final Widget child;
  final BannerMode mode;
  final BannerAction? action;
  final Alignment actionAlignment;

  @override
  Widget build(BuildContext context) {
    final asset = _bannerAssets[mode];

    final foregroundColor = context.colorScheme.primary;
    Color backgroundColor;

    if (mode == BannerMode.error) {
      backgroundColor = context.theme.isDarkMode
          ? const Color(0xFF5F2C29)
          : context.colorScheme.error.withOpacity(0.16);
    } else {
      backgroundColor = context.theme.isDarkMode
          ? const Color(0xFF3D3D3D)
          : const Color(0xFFF5F5F5);
    }

    Widget styledChild = DefaultTextStyle(
      style: context.textTheme.body2Regular.copyWith(color: foregroundColor),
      child: child,
    );

    if (asset != null) {
      final body = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: styledChild,
      );

      styledChild = Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SvgPicture.asset(
                asset,
                package: 'resources',
                height: 22,
                width: 22,
                color: foregroundColor,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  body,
                  if (action == null)
                    const SizedBox(height: 16)
                  else
                    Align(
                      alignment: actionAlignment,
                      child: action,
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return _BannerModeScope(
      mode: mode,
      child: Material(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: styledChild,
        ),
      ),
    );
  }
}

class BannerAction extends StatelessWidget {
  const BannerAction({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mode = _BannerModeScope.of(context);

    return TextButton(
      style: TextButton.styleFrom(
        textStyle: context.textTheme.titleSmall,
        foregroundColor: mode == BannerMode.error
            ? context.theme.isDarkMode
                ? const Color(0xFFFF8F87)
                : context.colorScheme.error
            : null,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class _BannerModeScope extends InheritedWidget {
  const _BannerModeScope({
    required this.mode,
    required super.child,
  });

  final BannerMode mode;

  static BannerMode of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_BannerModeScope>();
    assert(result != null, 'No _BannerModeScope found in context');
    return result!.mode;
  }

  @override
  bool updateShouldNotify(_BannerModeScope old) => old.mode != mode;
}

extension on AppTheme {
  bool get isDarkMode => brightness == Brightness.dark;
}
