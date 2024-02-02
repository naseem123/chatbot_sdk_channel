import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Input Field Test', () {
    group('Text With Label', () {
      late FocusNode focusNodeWithLabel;
      setUp(() {
        focusNodeWithLabel = FocusNode();
      });
      testWidgets('Empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: true,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: false,
          isInputTextFieldEmpty: true,
          isEnabled: true,
          isFocus: false,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          focusNode: focusNodeWithLabel,
          labelTextColor: const Color(0xff6b6b6b),
        );
      });

      testWidgets('Focused', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );
        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: false,
          isInputTextFieldEmpty: false,
          isEnabled: true,
          isFocus: true,
          borderColor: const Color(0xff000000),
          borderWidth: 1.5,
          focusNode: focusNodeWithLabel,
          labelTextColor: const Color(0xff6b6b6b),
          inputTextColor: const Color(0xdd000000),
        );
      });

      testWidgets('Filled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: false,
          isInputTextFieldEmpty: false,
          isEnabled: true,
          isFocus: false,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          focusNode: focusNodeWithLabel,
          labelTextColor: const Color(0xff6b6b6b),
          inputTextColor: const Color(0xdd000000),
        );
      });

      testWidgets('Disabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.disabled,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: false,
          isInputTextFieldEmpty: false,
          isEnabled: false,
          isFocus: false,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          focusNode: focusNodeWithLabel,
          labelTextColor: const Color(0xff6b6b6b),
          inputTextColor: const Color(0xff8e8e8e),
        );
      });

      testWidgets('Error', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithLabel,
            labelTextEnabled: true,
            isEmpty: false,
            fieldState: FieldState.error,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: false,
          isInputTextFieldEmpty: false,
          isEnabled: true,
          isFocus: false,
          borderColor: const Color(0xffa80700),
          borderWidth: 1.5,
          focusNode: focusNodeWithLabel,
          labelTextColor: const Color(0xffa80700),
          inputTextColor: const Color(0xdd000000),
        );
      });
    });
    group('Text Without Label', () {
      late FocusNode focusNodeWithoutLabel;
      setUp(() {
        focusNodeWithoutLabel = FocusNode();
      });
      testWidgets('Empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: true,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: true,
          isInputTextFieldEmpty: true,
          isEnabled: true,
          isFocus: false,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          focusNode: focusNodeWithoutLabel,
        );
      });

      testWidgets('Focused', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );
        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: true,
          isInputTextFieldEmpty: false,
          isEnabled: true,
          isFocus: true,
          borderColor: const Color(0xff000000),
          borderWidth: 1.5,
          focusNode: focusNodeWithoutLabel,
          inputTextColor: const Color(0xdd000000),
        );
      });

      testWidgets('Filled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.enabled,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: true,
          isInputTextFieldEmpty: false,
          isEnabled: true,
          isFocus: false,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          focusNode: focusNodeWithoutLabel,
          inputTextColor: const Color(0xdd000000),
        );
      });

      testWidgets('Disabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.disabled,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: true,
          isInputTextFieldEmpty: false,
          isEnabled: false,
          isFocus: false,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          focusNode: focusNodeWithoutLabel,
          inputTextColor: const Color(0xff8e8e8e),
        );
      });

      testWidgets('Error', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestInputField(
            brightness: Brightness.light,
            focusNode: focusNodeWithoutLabel,
            labelTextEnabled: false,
            isEmpty: false,
            fieldState: FieldState.error,
          ),
        );

        await expectationForInputField(
          tester: tester,
          isLabelTextEmpty: true,
          isInputTextFieldEmpty: false,
          isEnabled: true,
          isFocus: false,
          borderColor: const Color(0xffa80700),
          borderWidth: 1.5,
          focusNode: focusNodeWithoutLabel,
          inputTextColor: const Color(0xdd000000),
        );
      });
    });
  });
}

class _TestInputField extends StatelessWidget {
  const _TestInputField({
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
    final controller =
        TextEditingController(text: isEmpty ? '' : 'Field input');
    return AppTheme(
      brightness: brightness,
      builder: (BuildContext context) {
        return MaterialApp(
          theme: context.themeData,
          home: Material(
            color: brightness == Brightness.light ? Colors.white : Colors.black,
            child: InputField(
              focusNode: focusNode,
              controller: controller,
              onChanged: (value) {},
              labelText: labelTextEnabled ? 'DefaultLabel' : '',
              state: fieldState,
            ),
          ),
        );
      },
    );
  }
}

Future<void> expectationForInputField({
  required WidgetTester tester,
  required bool isLabelTextEmpty,
  required bool isInputTextFieldEmpty,
  required bool isEnabled,
  required bool isFocus,
  required Color borderColor,
  required double borderWidth,
  required FocusNode focusNode,
  Color? labelTextColor,
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
    focusNode.requestFocus();
    await tester.pumpAndSettle();
  }

  final decoration = decorator.decoration;
  expect(decoration.border, InputBorder.none);
  expect(decoration.enabled, isEnabled);

  if (isLabelTextEmpty) {
    expect(decoration.labelText?.isEmpty, true);
  } else {
    expect(decoration.labelText, 'DefaultLabel');

    final labelStyle = decoration.labelStyle;

    expect(labelStyle?.color, labelTextColor);
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

  if (!isInputTextFieldEmpty) {
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
}
