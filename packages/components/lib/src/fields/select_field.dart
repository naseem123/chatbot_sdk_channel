import 'package:components/components.dart';
import 'package:components/src/fields/helpers/chevron_down_icon.dart';
import 'package:components/src/fields/helpers/field_picker_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef _SelectFieldItemBuilder<T extends Object> = SelectFieldItem<T> Function(
  BuildContext,
  int,
);

class SelectField<T extends Object> extends StatefulWidget {
  const SelectField({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.state = FieldState.enabled,
    this.displayValue = '',
    this.focusNode,
    required this.selectedIndex,
  });

  final _SelectFieldItemBuilder<T> itemBuilder;
  final int itemCount;
  final ValueChanged<T> onChanged;
  final String? labelText;
  final String? hintText;
  final FieldState state;
  final String displayValue;
  final FocusNode? focusNode;
  final int selectedIndex;

  @override
  State<SelectField<T>> createState() => _SelectFieldState<T>();
}

class _SelectFieldState<T extends Object> extends State<SelectField<T>> {
  bool _isPickerActive = false;
  SelectFieldItem<T>? _item;

  @override
  Widget build(BuildContext context) {
    return InputField(
      state: widget.state,
      focusNode: widget.focusNode,
      value: _item?.label ?? widget.displayValue,
      onChanged: (value) {},
      suffixIcon: _suffixIcon,
      labelText: widget.labelText,
      readOnly: true,
      onTap: _openPicker,
    );
  }

  Widget? get _suffixIcon {
    if (_isPickerActive) return null;
    return ChevronDownIcon(isDisabled: widget.state == FieldState.disabled);
  }

  void _openPicker() {
    _isPickerActive = true;
    setState(() {});

    showCupertinoModalPopup<void>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (_) {
        return FieldPickerScaffold(
          onDone: () {
            Navigator.pop(context);
            if (_item != null) widget.onChanged(_item!.value);
          },
          child: CupertinoPicker.builder(
            scrollController:
                FixedExtentScrollController(initialItem: widget.selectedIndex),
            itemExtent: 40,
            backgroundColor: const Color(0xFFD7DADF),
            childCount: widget.itemCount,
            onSelectedItemChanged: (index) {
              _item = widget.itemBuilder(context, index);
              setState(() {});
            },
            itemBuilder: (context, index) {
              final item = widget.itemBuilder(context, index);
              return Center(child: item.child);
            },
          ),
        );
      },
    );

    _isPickerActive = false;
    setState(() {});
  }
}

class SelectFieldItem<T extends Object> {
  SelectFieldItem({
    required this.label,
    required this.value,
    Widget? child,
  }) : child = child ?? Text(label);

  final String label;
  final T value;
  final Widget? child;
}
