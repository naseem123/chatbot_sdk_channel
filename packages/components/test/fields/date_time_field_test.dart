import 'package:components/components.dart';
import 'package:components/src/fields/helpers/chevron_down_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date Time Field Test', () {
    late FocusNode focusNodeCupertinoDateTime;
    setUp(() {
      focusNodeCupertinoDateTime = FocusNode();
    });

    testWidgets('Cupertino Date Picker Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        _DateTimeFieldTest(
          brightness: Brightness.light,
          focusNode: focusNodeCupertinoDateTime,
          labelTextEnabled: true,
          isEmpty: true,
          fieldState: FieldState.enabled,
        ),
      );

      await expectationForDateTimeField(
        tester: tester,
        borderColor: const Color(0xffe0e0e0),
        borderWidth: 1,
        isEnabled: true,
        isLabelTextEmpty: false,
        inputTextEnabled: false,
        isFocus: false,
        cupertinoDateTime: true,
        labelTextStyleColor: const Color(0xff6b6b6b),
      );
    });

    group('With Label', () {
      late FocusNode focusNodeWithLabel;
      setUp(() {
        focusNodeWithLabel = FocusNode();
      });

      testWidgets('Empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: false,
            isEmpty: true,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: false,
          isFocus: false,
          cupertinoDateTime: false,
        );
      });

      testWidgets('Focused', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xff000000),
          borderWidth: 1.5,
          isEnabled: true,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xff6b6b6b),
          isFocus: true,
          focusNode: focusNodeWithLabel,
          inputTextEnabled: true,
          inputTextColor: const Color(0xdd000000),
          cupertinoDateTime: false,
        );
      });

      testWidgets('Filled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xff6b6b6b),
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
          cupertinoDateTime: false,
        );
      });

      testWidgets('Disabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.disabled,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: false,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xff6b6b6b),
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xff8e8e8e),
          cupertinoDateTime: false,
        );
      });

      testWidgets('Error', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.error,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffa80700),
          borderWidth: 1.5,
          isEnabled: true,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xffa80700),
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
          cupertinoDateTime: false,
        );
      });
    });

    group('Without Label', () {
      late FocusNode focusNodeWithoutLabel;
      setUp(() {
        focusNodeWithoutLabel = FocusNode();
      });

      testWidgets('Empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: true,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: false,
          isFocus: false,
          cupertinoDateTime: false,
        );
      });

      testWidgets('Focused', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );
        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xff000000),
          borderWidth: 1.5,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: true,
          focusNode: focusNodeWithoutLabel,
          inputTextColor: const Color(0xdd000000),
          cupertinoDateTime: false,
        );
      });

      testWidgets('Filled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
          cupertinoDateTime: false,
        );
      });

      testWidgets('Disabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.disabled,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: false,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xff8e8e8e),
          cupertinoDateTime: false,
        );
      });

      testWidgets('Error', (WidgetTester tester) async {
        await tester.pumpWidget(
          _DateTimeFieldTest(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.error,
          ),
        );

        await expectationForDateTimeField(
          tester: tester,
          borderColor: const Color(0xffa80700),
          borderWidth: 1.5,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
          cupertinoDateTime: false,
        );
      });
    });
  });
}

class _DateTimeFieldTest extends StatelessWidget {
  const _DateTimeFieldTest({
    required this.brightness,
    required this.focusNode,
    required this.labelTextEnabled,
    required this.isEmpty,
    required this.fieldState,
  });
  final Brightness brightness;
  final FocusNode focusNode;
  final bool labelTextEnabled;
  final bool isEmpty;
  final FieldState fieldState;

  @override
  Widget build(BuildContext context) {
    final dateTimeValue = isEmpty
        ? null
        : DateTime(
            2022,
            4,
            4,
          );
    return AppTheme(
      brightness: brightness,
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.themeData,
          home: Material(
            color: brightness == Brightness.light ? Colors.white : Colors.black,
            child: DateTimeField(
              focusNode: focusNode,
              displayValue: dateTimeValue,
              labelText: labelTextEnabled ? 'DefaultLabel' : '',
              state: fieldState,
              onChanged: (DateTime value) {},
              initialDateTime: DateTime(
                2022,
                4,
                5,
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<void> expectationForDateTimeField({
  required WidgetTester tester,
  required Color borderColor,
  required double borderWidth,
  required bool isEnabled,
  required bool isLabelTextEmpty,
  required bool inputTextEnabled,
  required bool isFocus,
  required bool cupertinoDateTime,
  Color? labelTextStyleColor,
  FocusNode? focusNode,
  Color? inputTextColor,
}) async {
  final textFieldFinder = find.byType(TextField);
  final inputDecoratorFinder = find.byType(InputDecorator);

  final textFieldInputDecoratorFinder = find.descendant(
    of: textFieldFinder,
    matching: inputDecoratorFinder,
  );

  final decorator =
      tester.widget<InputDecorator>(textFieldInputDecoratorFinder);

  if (isFocus) {
    focusNode?.requestFocus();
    await tester.pumpAndSettle();
  }

  final decoration = decorator.decoration;
  expect(decoration.border, InputBorder.none);
  expect(decoration.enabled, isEnabled);
  if (isLabelTextEmpty) {
    expect(decoration.labelText!.isEmpty, true);
  } else {
    expect(decoration.labelText, 'DefaultLabel');

    final labelStyle = decoration.labelStyle;

    expect(labelStyle?.color, labelTextStyleColor);
    expect(labelStyle?.fontFamily, 'SFPro');
  }

  final animatedContainerFinder = find.byType(AnimatedContainer);
  final animatedDecorationFinder = tester.widget<AnimatedContainer>(
    animatedContainerFinder,
  );

  expect(
    (animatedDecorationFinder.decoration as BoxDecoration?)?.border,
    Border.all(
      color: borderColor,
      width: borderWidth,
    ),
  );

  if (inputTextEnabled) {
    if (cupertinoDateTime) {
      await tester.tap(textFieldFinder);
      await tester.pumpAndSettle();

      final datePickerFinder = find.byType(CupertinoDatePicker);
      expect(datePickerFinder, findsOneWidget);

      final datePickerMonthTextFinder = find.descendant(
        of: datePickerFinder,
        matching: find.text('April'),
      );
      expect(datePickerMonthTextFinder, findsOneWidget);

      final datePickerDayTextFinder = find.descendant(
        of: datePickerFinder,
        matching: find.text('5'),
      );
      expect(datePickerDayTextFinder, findsOneWidget);

      final datePickerYearTextFinder = find.descendant(
        of: datePickerFinder,
        matching: find.text('2021'),
      );
      expect(datePickerYearTextFinder, findsOneWidget);

      await tester.drag(
        find.text('3'),
        const Offset(0, 32),
        touchSlopX: 0,
        warnIfMissed: false,
      );

      await tester.pumpAndSettle();
      await tester.pump(
        const Duration(milliseconds: 500),
      );

      final doneTextFinder = find.descendant(
        of: datePickerFinder,
        matching: find.text('Done'),
      );
      await tester.tap(doneTextFinder);
      await tester.pumpAndSettle();
    }
    final inputTextFinder = find.descendant(
      of: textFieldFinder,
      matching: find.text('04/04/2022'),
    );
    expect(inputTextFinder, findsOneWidget);

    final inputTextWidget = tester.widget<EditableText>(inputTextFinder);
    expect(
      inputTextWidget.style.color,
      inputTextColor,
    );
    expect(inputTextWidget.style.fontFamily, 'SFPro');
  }

  final dropDownIconFinder = find.descendant(
    of: textFieldFinder,
    matching: find.byType(ChevronDownIcon),
  );
  expect(dropDownIconFinder, findsOneWidget);
}
