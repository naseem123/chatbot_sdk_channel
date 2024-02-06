import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.onChanged,
    this.onTap,
    this.labelText,
    this.hintText,
    this.state = FieldState.enabled,
    this.value = '',
    this.inputFormatters,
    this.textInputType,
    this.textInputAction = TextInputAction.next,
    this.obscuringCharacter = '•',
    this.focusNode,
  });

  final ValueChanged<String> onChanged;
  final String? labelText;
  final String? hintText;
  final FieldState state;
  final String value;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final String obscuringCharacter;
  final FocusNode? focusNode;

  bool get isDisabled => state == FieldState.disabled;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _hasValue = widget.value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      onTap: widget.onTap ?? () {},
      labelText: widget.labelText,
      hintText: widget.hintText,
      state: widget.state,
      value: widget.value,
      onChanged: (value) {
        widget.onChanged(value);

        _hasValue = value.isNotEmpty;
        setState(() {});
      },
      obscureText: _obscure,
      suffixIcon: _suffixIcon,
      inputFormatters: widget.inputFormatters,
      textInputType: widget.textInputType,
      textInputAction: widget.textInputAction,
      obscuringCharacter: widget.obscuringCharacter,
      focusNode: widget.focusNode,
      autofillHints: const [AutofillHints.password],
    );
  }

  IconButton? get _suffixIcon {
    if (_hasValue && widget.state != FieldState.disabled) {
      return IconButton(
        icon: SvgPicture.asset(
          _obscure
              ? 'assets/icons/visibility.svg'
              : 'assets/icons/visibility_off.svg',
          package: 'resources',
        ),
        onPressed: () {
          _obscure = !_obscure;
          setState(() {});
        },
      );
    }

    return null;
  }
}
