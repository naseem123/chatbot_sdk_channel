import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resources/resources.dart';

class PasswordValidityIndicator extends StatelessWidget {
  const PasswordValidityIndicator({
    required this.label,
    required this.isValid,
    super.key,
  });

  final String label;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: SvgPicture.asset(
              isValid
                  ? 'assets/icons/checkmark_checked_icon.svg'
                  : 'assets/icons/checkmark_unchecked_icon.svg',
              package: 'resources',
            ),
          ),
          Text(
            label,
            style: context.textTheme.body2Regular.copyWith(
              color: isValid
                  ? context.colorScheme.primary
                  : const Color(0xFFA3A3A3),
            ),
          ),
        ],
      ),
    );
  }
}
