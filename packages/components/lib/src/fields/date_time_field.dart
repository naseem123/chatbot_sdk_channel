import 'package:components/components.dart';
import 'package:components/src/fields/helpers/chevron_down_icon.dart';
import 'package:components/src/fields/helpers/field_picker_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeField extends StatefulWidget {
  DateTimeField({
    super.key,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.displayPattern = 'MM/dd/y',
    this.state = FieldState.enabled,
    this.selectionMode = DateSelectionMode.date,
    DateTime? initialDateTime,
    this.minimumDate,
    this.maximumDate,
    this.minimumYear = 1,
    this.maximumYear,
    this.use24hFormat = false,
    this.dateOrder,
    this.displayValue,
    this.focusNode,
  }) : initialDateTime = initialDateTime ?? DateTime.now();

  final ValueChanged<DateTime> onChanged;
  final String? labelText;
  final String? hintText;
  final String displayPattern;
  final FieldState state;
  final DateSelectionMode selectionMode;
  final DateTime initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final int minimumYear;
  final int? maximumYear;
  final bool use24hFormat;
  final DatePickerDateOrder? dateOrder;
  final DateTime? displayValue;
  final FocusNode? focusNode;

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  bool _isPickerActive = false;
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    final value = _dateTime ?? widget.displayValue;
    return InputField(
      focusNode: widget.focusNode,
      state: widget.state,
      value: value == null
          ? ''
          : DateFormat(widget.displayPattern).format(
              value,
            ),
      onChanged: (value) {},
      suffixIcon: _suffixIcon,
      labelText: widget.labelText,
      hintText: widget.hintText,
      readOnly: true,
      onTap: _openPicker,
    );
  }

  Widget? get _suffixIcon {
    if (_isPickerActive) return null;
    return ChevronDownIcon(isDisabled: widget.state == FieldState.disabled);
  }

  Future<void> _openPicker() async {
    _isPickerActive = true;
    setState(() {});

    await showCupertinoModalPopup<void>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (_) {
        return FieldPickerScaffold(
          onDone: () {
            Navigator.pop(context);

            if (_dateTime != null) {
              widget.onChanged(_dateTime!);
            } else {
              _dateTime = DateTime(2000);
              widget.onChanged(_dateTime!);
            }
            setState(() {});
          },
          child: CupertinoDatePicker(
            backgroundColor: const Color(0xFFD7DADF),
            mode: CupertinoDatePickerMode.values.byName(
              widget.selectionMode.name,
            ),
            onDateTimeChanged: (dateTime) => _dateTime = dateTime,
            dateOrder: widget.dateOrder,
            initialDateTime: _dateTime ?? widget.initialDateTime,
            maximumDate: widget.maximumDate,
            minimumDate: widget.minimumDate,
            maximumYear: widget.maximumYear,
            minimumYear: widget.minimumYear,
            use24hFormat: widget.use24hFormat,
          ),
        );
      },
    );

    _isPickerActive = false;
    setState(() {});
  }
}

enum DateSelectionMode {
  ///  4 | 14 | PM
  time,

  /// July | 13 | 2012
  date,

  /// Fri Jul 13 | 4 | 14 | PM
  dateAndTime,
}
