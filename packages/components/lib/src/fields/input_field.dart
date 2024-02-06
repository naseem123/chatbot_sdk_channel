import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resources/resources.dart';

enum FieldState { enabled, disabled, error }

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.state = FieldState.enabled,
    this.value = '',
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.inputFormatters,
    this.fillColor,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.obscuringCharacter = '•',
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
  }) : assert(
          maxLength == null || inputFormatters == null,
          '\n\nEither use "maxLength" or "inputFormatters".\n',
        );

  final ValueChanged<String> onChanged;
  final String? labelText;
  final String? hintText;
  final FieldState state;
  final String value;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final bool readOnly;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final String obscuringCharacter;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  bool get isDisabled => state == FieldState.disabled;

  bool get _hasError => state == FieldState.error;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 12, horizontal: 16);
    final effectiveInputFormatters = maxLength == null
        ? inputFormatters
        : [LengthLimitingTextInputFormatter(maxLength)];
    final labelStyle = context.textTheme.body1Regular.copyWith(
      color: _hasError ? context.colorScheme.error : const Color(0xFF6B6B6B),
    );

    var actualFillColor = fillColor;
    var style = context.textTheme.body1Regular;
    if (isDisabled) {
      actualFillColor = const Color(0xFFFAFAFA);
      style = style.copyWith(color: const Color(0xFF8E8E8E));
    }

    return InputDecorationBuilder(
      focusNode: focusNode,
      controller: controller,
      value: value,
      hasError: state == FieldState.error,
      fillColor: actualFillColor,
      builder: (context, data) {
        final floatingLabelStyle = context.textTheme.overline!.copyWith(
          color: data.showError
              ? context.colorScheme.error
              : const Color(0xFF8E8E8E),
        );

        return TextField(
          scrollPadding: scrollPadding,
          controller: data.controller,
          enabled: !isDisabled,
          obscureText: obscureText,
          style: style,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            contentPadding: padding,
            labelText: labelText,
            hintText: hintText,
            labelStyle: labelStyle,
            hintStyle: labelStyle,
            floatingLabelStyle: floatingLabelStyle,
            suffixIcon: suffixIcon,
          ),
          onChanged: onChanged,
          keyboardType: textInputType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          onEditingComplete: FocusScope.of(context).nextFocus,
          inputFormatters: effectiveInputFormatters,
          readOnly: readOnly,
          onTap: onTap,
          obscuringCharacter: obscuringCharacter,
          textCapitalization: textCapitalization,
          enableInteractiveSelection: enableInteractiveSelection,
        );
      },
    );
  }
}

class InputDecorationBuilder extends StatefulWidget {
  const InputDecorationBuilder({
    super.key,
    required this.builder,
    required this.hasError,
    required this.value,
    this.controller,
    this.fillColor,
    this.focusNode,
  });

  final Widget Function(BuildContext, _DecorationData) builder;
  final bool hasError;
  final String value;
  final TextEditingController? controller;
  final Color? fillColor;
  final FocusNode? focusNode;

  @override
  State<InputDecorationBuilder> createState() => _InputDecorationBuilderState();
}

class _InputDecorationBuilderState extends State<InputDecorationBuilder> {
  late final TextEditingController _controller;

  bool _hasFocus = false;
  bool _hasError = false;
  String _oldValue = '';

  @override
  void initState() {
    super.initState();
    _hasError = widget.hasError;
    _controller = widget.controller ?? TextEditingController(text: widget.value)
      ..addListener(_onChanged);
  }

  @override
  void didUpdateWidget(InputDecorationBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _hasError = widget.hasError;

    if (oldWidget.value != widget.value) {
      final selection = _controller.selection;
      _controller.text = widget.value;

      if (_controller.isSelectionWithinTextBounds(selection)) {
        _controller.selection = selection;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      onFocusChange: (hasFocus) {
        _hasFocus = hasFocus;
        if (mounted) setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: border,
          color: widget.fillColor,
        ),
        child: widget.builder(
          context,
          _DecorationData(
            controller: _controller,
            showError: _hasError,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller != null) _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    final value = _controller.text;

    if (_hasError && _oldValue != value) {
      _hasError = false;

      if (mounted) setState(() {});
    }

    _oldValue = value;
  }

  Border get border {
    Color? color;
    double? width;

    if (_hasError) {
      color = context.colorScheme.error;
      width = 1.5;
    } else if (_hasFocus) {
      color = context.colorScheme.primary;
      width = 1.5;
    }

    return Border.all(
      color: color ?? const Color(0xFFE0E0E0),
      width: width ?? 1,
    );
  }
}

class _DecorationData {
  const _DecorationData({
    required this.controller,
    required this.showError,
  });

  final TextEditingController controller;
  final bool showError;

  bool get isEmpty => controller.text.isEmpty;
}
