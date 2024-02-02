import 'package:components/components.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Password Field Test', () {
    group('Icon = Show', () {
      late FocusNode focusNodeIconShow;
      setUp(() {
        focusNodeIconShow = FocusNode();
      });
      testWidgets('Empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestPasswordField(
            brightness: Brightness.light,
            focusNode: focusNodeIconShow,
            isEmpty: true,
          ),
        );
        await expectationForPasswordField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          labelTextColor: const Color(0xff6b6b6b),
          isFocused: false,
          focusNode: focusNodeIconShow,
          hasValue: false,
          iconHide: false,
        );
      });

      testWidgets('Focused', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestPasswordField(
            brightness: Brightness.light,
            focusNode: focusNodeIconShow,
            isEmpty: false,
          ),
        );
        await expectationForPasswordField(
          tester: tester,
          borderColor: const Color(0xff000000),
          borderWidth: 1.5,
          labelTextColor: const Color(0xff6b6b6b),
          isFocused: true,
          focusNode: focusNodeIconShow,
          hasValue: true,
          obscureText: true,
          inputTextColor: const Color(0xdd000000),
          iconHide: false,
        );
      });

      testWidgets('Filled', (WidgetTester tester) async {
        await tester.pumpWidget(
          _TestPasswordField(
            brightness: Brightness.light,
            focusNode: focusNodeIconShow,
            isEmpty: false,
          ),
        );

        await expectationForPasswordField(
          tester: tester,
          borderColor: const Color(0xffe0e0e0),
          borderWidth: 1,
          labelTextColor: const Color(0xff6b6b6b),
          isFocused: false,
          focusNode: focusNodeIconShow,
          hasValue: true,
          obscureText: true,
          inputTextColor: const Color(0xdd000000),
          iconHide: false,
        );
      });
    });
  });

  group('Icon = Hide', () {
    late FocusNode focusNodeIconHide;
    setUp(() {
      focusNodeIconHide = FocusNode();
    });
    testWidgets('Empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestPasswordField(
          brightness: Brightness.light,
          focusNode: focusNodeIconHide,
          isEmpty: true,
        ),
      );

      await expectationForPasswordField(
        tester: tester,
        borderColor: const Color(0xffe0e0e0),
        borderWidth: 1,
        labelTextColor: const Color(0xff6b6b6b),
        isFocused: false,
        focusNode: focusNodeIconHide,
        hasValue: false,
        iconHide: false,
      );
    });

    testWidgets('Focused', (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestPasswordField(
          brightness: Brightness.light,
          focusNode: focusNodeIconHide,
          isEmpty: false,
        ),
      );
      await expectationForPasswordField(
        tester: tester,
        borderColor: const Color(0xff000000),
        borderWidth: 1.5,
        labelTextColor: const Color(0xff6b6b6b),
        isFocused: true,
        focusNode: focusNodeIconHide,
        hasValue: true,
        obscureText: true,
        inputTextColor: const Color(0xdd000000),
        iconHide: true,
      );
    });

    testWidgets('Filled', (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestPasswordField(
          brightness: Brightness.light,
          focusNode: focusNodeIconHide,
          isEmpty: false,
        ),
      );

      await expectationForPasswordField(
        tester: tester,
        borderColor: const Color(0xffe0e0e0),
        borderWidth: 1,
        labelTextColor: const Color(0xff6b6b6b),
        isFocused: false,
        focusNode: focusNodeIconHide,
        hasValue: true,
        obscureText: true,
        inputTextColor: const Color(0xdd000000),
        iconHide: true,
      );
    });
  });
}

class _TestPasswordField extends StatelessWidget {
  const _TestPasswordField({
    required this.brightness,
    required this.focusNode,
    required this.isEmpty,
  });
  final Brightness brightness;
  final FocusNode focusNode;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      brightness: brightness,
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.themeData,
          home: Material(
            color: brightness == Brightness.light ? Colors.white : Colors.black,
            child: PasswordField(
              focusNode: focusNode,
              labelText: 'DefaultLabel',
              onChanged: (String value) {},
              value: isEmpty ? '' : 'Hidden field input',
            ),
          ),
        );
      },
    );
  }
}

Future<void> expectationForPasswordField({
  required WidgetTester tester,
  required Color borderColor,
  required double borderWidth,
  required Color labelTextColor,
  required bool isFocused,
  required FocusNode focusNode,
  required bool hasValue,
  required bool iconHide,
  Color? inputTextColor,
  bool? obscureText,
}) async {
  final textFieldFinder = find.byType(TextField);
  final inputDecoratorFinder = find.byType(InputDecorator);
  final textFieldInputDecoratorFinder =
      find.descendant(of: textFieldFinder, matching: inputDecoratorFinder);
  final decorator =
      tester.widget<InputDecorator>(textFieldInputDecoratorFinder);

  if (isFocused) {
    focusNode.requestFocus();
    await tester.pumpAndSettle();
  }

  final decoration = decorator.decoration;
  expect(decoration.border, InputBorder.none);
  expect(decoration.enabled, true);
  expect(decoration.labelText, 'DefaultLabel');

  final labelStyle = decoration.labelStyle;

  expect(labelStyle?.color, labelTextColor);
  expect(labelStyle?.fontFamily, 'SFPro');

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

  if (hasValue) {
    final suffixIconFinder = find.descendant(
      of: textFieldFinder,
      matching: find.byType(IconButton),
    );
    expect(suffixIconFinder, findsOneWidget);
    final inputTextFinder = find.descendant(
      of: textFieldFinder,
      matching: find.text('Hidden field input'),
    );
    expect(inputTextFinder, findsOneWidget);
    final inputTextWidget = tester.widget<EditableText>(inputTextFinder);
    expect(
      inputTextWidget.style.color,
      inputTextColor,
    );
    expect(inputTextWidget.style.fontFamily, 'SFPro');
    expect(inputTextWidget.obscureText, obscureText);
    expect(inputTextWidget.obscuringCharacter, '•');
    if (iconHide) {
      await tester.tap(suffixIconFinder);
      await tester.pumpAndSettle();
      final inputTextWidget = tester.widget<EditableText>(inputTextFinder);
      expect(inputTextWidget.obscureText, false);
    }
  }
}
