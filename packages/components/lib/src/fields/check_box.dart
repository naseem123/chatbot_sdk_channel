import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TickBoxTile extends StatelessWidget {
  const TickBoxTile({
    super.key,
    required this.label,
    this.value = false,
    this.isDisabled = false,
    this.margin = const EdgeInsets.only(
      bottom: 16,
    ),
    this.onPressed,
  });

  final Widget label;
  final bool value;
  final bool isDisabled;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              key: key,
              padding: const EdgeInsets.only(
                left: 4,
              ),
              onPressed: isDisabled ? null : onPressed,
              icon: SvgPicture.asset(
                value
                    ? 'assets/icons/checked_check_box_icon.svg'
                    : 'assets/icons/check_box_icon.svg',
                package: 'resources',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
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
