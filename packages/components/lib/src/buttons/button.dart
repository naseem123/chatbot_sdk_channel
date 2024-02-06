import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

enum ButtonState { active, loading, disabled }

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.child,
    required this.onPressed,
    this.icon,
    this.primaryColor,
    this.state = ButtonState.active,
  });

  const factory Button.accent(
      {Key? key,
        required Widget child,
        required VoidCallback onPressed,
        ButtonState state,
        Color? primaryColor}) = _AccentButton;

  const factory Button.destructive({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    ButtonState state,
  }) = _DestructiveButton;

  const factory Button.secondary({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    ButtonState state,
    Widget? icon,
  }) = _SecondaryButton;

  const factory Button.secondaryWhite({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    ButtonState state,
    Widget? icon,
  }) = _SecondaryWhiteButton;

  final Widget child;
  final VoidCallback onPressed;
  final Widget? icon;
  final ButtonState state;
  final Color? primaryColor;

  ButtonStyle get _style {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shape: const BeveledRectangleBorder(),
      minimumSize: const Size.fromHeight(56),
    );
  }

  ButtonStyle get _secondaryStyle {
    return OutlinedButton.styleFrom(
      shape: const BeveledRectangleBorder(),
      minimumSize: const Size.fromHeight(56),
    );
  }

  bool get isDisabled => state == ButtonState.disabled;

  bool get isInactive => state != ButtonState.active;

  bool get isLoading => state == ButtonState.loading;

  @override
  Widget build(BuildContext context) {
    ButtonStyle? style;
    final isLight = context.themeData.brightness == Brightness.light;
    if (isDisabled) {
      if (isLight) {
        style = ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF696969),
          foregroundColor: const Color(0xFF8F8F8F),
        );
      } else {
        style = ElevatedButton.styleFrom(
          backgroundColor: context.theme.color.primary.white,
          foregroundColor: context.theme.color.primary.black.withOpacity(0.16),
        );
      }
    } else {
      style = ElevatedButton.styleFrom(
        foregroundColor: isLight
            ? context.theme.color.primary.white
            : context.theme.color.primary.black,
      );
    }

    return IgnorePointer(
      ignoring: isInactive,
      child: ElevatedButton(
        style: _style.merge(style),
        onPressed: onPressed,
        child: _child(context.colorScheme.surface),
      ),
    );
  }

  Widget _child(Color color) {
    switch (state) {
      case ButtonState.active:
      case ButtonState.disabled:
        return icon == null
            ? child
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            const SizedBox(width: 12),
            Flexible(child: child)
          ],
        );
      case ButtonState.loading:
        return SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(color: color, strokeWidth: 2),
        );
    }
  }
}

class _AccentButton extends Button {
  const _AccentButton(
      {super.key,
        required super.child,
        required super.onPressed,
        super.state,
        super.primaryColor});

  @override
  Widget build(BuildContext context) {
    ButtonStyle style;
    if (isDisabled) {
      style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFABA6EB),
        foregroundColor: Colors.white.withOpacity(0.4),
      );
    } else {
      style = ElevatedButton.styleFrom(
        backgroundColor: primaryColor ?? context.colorScheme.primary,
        foregroundColor: context.theme.brightness == Brightness.dark
            ? context.colorScheme.primary
            : context.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
    }

    return IgnorePointer(
      ignoring: isInactive,
      child: ElevatedButton(
        style: style.merge(_style),
        onPressed: onPressed,
        child: _child(context.colorScheme.surface),
      ),
    );
  }
}

class _DestructiveButton extends Button {
  const _DestructiveButton({
    super.key,
    required super.child,
    required super.onPressed,
    super.state,
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle style;
    if (isDisabled) {
      style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDDA6A4),
        foregroundColor: Colors.white.withOpacity(0.56),
      );
    } else {
      style = ElevatedButton.styleFrom(
        backgroundColor: context.secondaryColor.brightRed,
        foregroundColor: context.theme.brightness == Brightness.dark
            ? context.colorScheme.primary
            : context.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
    }

    return IgnorePointer(
      ignoring: isInactive,
      child: ElevatedButton(
        style: style.merge(_style),
        onPressed: onPressed,
        child: _child(context.colorScheme.surface),
      ),
    );
  }
}

class _SecondaryButton extends Button {
  const _SecondaryButton({
    super.key,
    required super.child,
    required super.onPressed,
    super.state,
    super.icon,
  });

  @override
  Widget build(BuildContext context) {
    final primaryBorderSize = BorderSide(color: context.colorScheme.primary);
    final borderSide = Theme.of(context).brightness == Brightness.dark
        ? primaryBorderSize
        : null;

    ButtonStyle style;
    if (isDisabled) {
      style = OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFCCCCCC),
        side: borderSide,
      );
    } else {
      style = OutlinedButton.styleFrom(side: borderSide);
    }

    return IgnorePointer(
      ignoring: isInactive,
      child: OutlinedButton(
        style: _secondaryStyle.merge(style),
        onPressed: onPressed,
        child: _child(context.colorScheme.primary),
      ),
    );
  }
}

class _SecondaryWhiteButton extends Button {
  const _SecondaryWhiteButton({
    super.key,
    required super.child,
    required super.onPressed,
    super.state,
    super.icon,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.secondaryColor.gray87;

    return IgnorePointer(
      ignoring: isInactive,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ).merge(_secondaryStyle),
        onPressed: onPressed,
        child: _child(context.colorScheme.surface),
      ),
    );
  }
}
