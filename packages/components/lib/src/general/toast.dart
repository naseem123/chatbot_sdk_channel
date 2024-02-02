import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resources/resources.dart';

enum ToastMode { normal, success, error }

const Map<ToastMode, String> _toastAssets = {
  ToastMode.success: 'assets/icons/toast_check.svg',
  ToastMode.error: 'assets/icons/warning.svg'
};

void showToast(
  BuildContext context, {
  required Widget child,
  ToastMode mode = ToastMode.normal,
  Duration duration = const Duration(seconds: 4),
}) {
  final asset = _toastAssets[mode];
  Color backgroundColor;
  Color foregroundColor;

  if (mode == ToastMode.error) {
    foregroundColor = context.colorScheme.primary;
    backgroundColor = context.colorScheme.error.withOpacity(0.16);
  } else {
    foregroundColor = context.colorScheme.onPrimary;
    backgroundColor = context.colorScheme.primary.withOpacity(0.8);
  }

  backgroundColor = Color.alphaBlend(
    backgroundColor,
    Theme.of(context).scaffoldBackgroundColor,
  );

  Widget styledChild = DefaultTextStyle(
    style: context.textTheme.body2Regular.copyWith(
      color: foregroundColor,
      height: 1.25,
    ),
    child: child,
  );

  if (asset != null) {
    styledChild = Row(
      children: [
        SvgPicture.asset(
          asset,
          package: 'resources',
          height: 20,
          width: 20,
          color: foregroundColor,
        ),
        const SizedBox(width: 12),
        Expanded(child: styledChild),
      ],
    );
  }

  final snackBar = SnackBar(
    content: styledChild,
    backgroundColor: backgroundColor,
    duration: duration,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showGenericErrorToast(BuildContext context) {
  showToast(
    context,
    child: const Text('An error has occurred. Please try again.'),
    mode: ToastMode.error,
  );
}

void showTokenExpiredErrorToast(BuildContext context) {
  showToast(
    context,
    child: const Text('Bank token is expired. Please try again.'),
    mode: ToastMode.error,
  );
}
