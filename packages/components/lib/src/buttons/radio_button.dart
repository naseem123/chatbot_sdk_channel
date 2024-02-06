import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.label,
    this.value = false,
    this.isDisabled = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    required this.onChanged,
  });

  final Widget label;
  final bool value;
  final bool isDisabled;
  final EdgeInsets? margin;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : (() => onChanged(!value)),
      child: Container(
        margin: margin,
        child: Row(
          children: [
            IconButton(
              padding: const EdgeInsets.only(top: 2, left: 2),
              onPressed: isDisabled ? null : () => onChanged(!value),
              icon: SvgPicture.asset(
                value
                    ? 'assets/icons/filled_radio_button_icon.svg'
                    : 'assets/icons/radio_button_icon.svg',
                package: 'resources',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DefaultTextStyle(
                style: context.textTheme.body1Regular,
                child: label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
