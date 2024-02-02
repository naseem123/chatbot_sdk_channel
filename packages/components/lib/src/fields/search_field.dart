import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resources/resources.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color? color;
    BoxBorder? border;
    if (isDark) {
      color = context.colorScheme.surface;
      border = Border.all(color: color);
    }

    return DecoratedBox(
      decoration: BoxDecoration(border: border),
      child: TextField(
        onChanged: onChanged,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: UnconstrainedBox(
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              package: 'resources',
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
