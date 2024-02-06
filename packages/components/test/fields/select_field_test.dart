import 'package:components/components.dart';
import 'package:components/src/fields/helpers/chevron_down_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Select Field Test', () {
    group('Dropdown With Label', () {
      late FocusNode focusNodeWithLabel;
      setUp(() {
        focusNodeWithLabel = FocusNode();
      });
      testWidgets('Empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: true,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xff6b6b6b),
          inputTextEnabled: false,
          isFocus: false,
        );
      });

      testWidgets('Focused', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForSelectField(
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
        );
      });

      testWidgets('Filled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xff6b6b6b),
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
        );
      });

      testWidgets('Disabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.disabled,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: false,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xff6b6b6b),
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xff8e8e8e),
        );
      });

      testWidgets('Error', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.error,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffa80700),
          borderWidth: 1.5,
          isEnabled: true,
          isLabelTextEmpty: false,
          labelTextStyleColor: const Color(0xffa80700),
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
        );
      });
    });
    group('Dropdown Without Label', () {
      late FocusNode focusNodeWithoutLabel;
      setUp(() {
        focusNodeWithoutLabel = FocusNode();
      });
      testWidgets('Empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: true,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: false,
          isFocus: false,
        );
      });

      testWidgets('Focused', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );
        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xff000000),
          borderWidth: 1.5,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: true,
          focusNode: focusNodeWithoutLabel,
          inputTextColor: const Color(0xdd000000),
        );
      });

      testWidgets('Filled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
        );
      });

      testWidgets('Disabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.disabled,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          isEnabled: false,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xff8e8e8e),
        );
      });

      testWidgets('Error', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestSelectField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.error,
          ),
        );

        await expectationForSelectField(
          tester: tester,
          borderColor: const Color(0xffa80700),
          borderWidth: 1.5,
          isEnabled: true,
          isLabelTextEmpty: true,
          inputTextEnabled: true,
          isFocus: false,
          inputTextColor: const Color(0xdd000000),
        );
      });
    });
  });
}

class _TestSelectField extends StatelessWidget {
  const _TestSelectField({
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
    final displayValue = isEmpty ? '' : 'Field input';
    return AppTheme(
      brightness: brightness,
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.themeData,
          home: Material(
            color: brightness == Brightness.light ? Colors.white : Colors.black,
            child: SelectField(
              selectedIndex: 0,
              focusNode: focusNode,
              state: fieldState,
              displayValue: displayValue,
              labelText: labelTextEnabled ? 'DefaultLabel' : '',
              onChanged: (Object value) {},
              itemBuilder: (context, index) {
                return SelectFieldItem(
                  child: Text(
                    index.toString(),
                  ),
                  value: index,
                  label: index.toString(),
                );
              },
              itemCount: 2,
            ),
          ),
        );
      },
    );
  }
}

Future<void> expectationForSelectField({
  required WidgetTester tester,
  required Color borderColor,
  required double borderWidth,
  required bool isEnabled,
  required bool isLabelTextEmpty,
  required bool inputTextEnabled,
  required bool isFocus,
  Color? labelTextStyleColor,
  FocusNode? focusNode,
  Color? inputTextColor,
}) async {
  final textFieldFinder = find.byType(TextField);
  final inputDecoratorFinder = find.byType(InputDecorator);
  final textFieldInputDecoratorFinder =
      find.descendant(of: textFieldFinder, matching: inputDecoratorFinder);
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
  final animatedDecorationFinder =
      tester.widget<AnimatedContainer>(animatedContainerFinder);

  expect(
    (animatedDecorationFinder.decoration as BoxDecoration?)?.border,
    Border.all(
      color: borderColor,
      width: borderWidth,
    ),
  );

  if (inputTextEnabled) {
    final inputTextFinder = find.descendant(
      of: textFieldFinder,
      matching: find.text('Field input'),
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
