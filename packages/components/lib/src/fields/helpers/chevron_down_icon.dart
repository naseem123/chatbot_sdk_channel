import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChevronDownIcon extends StatelessWidget {
  const ChevronDownIcon({super.key, this.isDisabled = false});

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SvgPicture.asset(
        'assets/icons/chevron_down.svg',
        package: 'resources',
        color: isDisabled ? const Color(0xFFB8B8B8) : null,
      ),
    );
  }
}
