import 'package:components/components.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search Test', () {
    testWidgets('Empty', (WidgetTester tester) async {
      await tester.pumpWidget(_TestSearchField());
      await _expectationForSearchField(tester: tester, enterText: false);
    });

    testWidgets('Focused', (WidgetTester tester) async {
      await tester.pumpWidget(_TestSearchField());
      await _expectationForSearchField(tester: tester, enterText: true);
    });
  });
}

class _TestSearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      brightness: Brightness.light,
      builder: (BuildContext context) {
        return MaterialApp(
          theme: context.themeData,
          home: Material(
            color: Colors.white,
            child: SearchField(
              onChanged: (String value) {},
            ),
          ),
        );
      },
    );
  }
}

Future<void> _expectationForSearchField({
  required WidgetTester tester,
  required bool enterText,
}) async {
  final textFieldFinder = find.byType(TextField);
  final inputDecoratorFinder = find.byType(InputDecorator);

  final textFieldInputDecoratorFinder = find.descendant(
    of: textFieldFinder,
    matching: inputDecoratorFinder,
  );

  final decorator = tester.widget<InputDecorator>(
    textFieldInputDecoratorFinder,
  );

  final decoration = decorator.decoration;
  expect(decoration.enabled, true);
  expect(decoration.hintText, 'Search');
  expect(decoration.border, InputBorder.none);

  final decoratedBoxFinder = find.byType(DecoratedBox);
  final decoratedBoxWidgetFinder = tester.widget<DecoratedBox>(
    decoratedBoxFinder,
  );

  expect(decoratedBoxWidgetFinder.decoration, const BoxDecoration());

  if (enterText) {
    await tester.enterText(textFieldFinder, 'Value');
    await tester.pumpAndSettle();

    final hintTextFinder = find.descendant(
      of: textFieldFinder,
      matching: find.text('Value'),
    );
    expect(hintTextFinder, findsOneWidget);

    final hintTextWidget = tester.widget<EditableText>(hintTextFinder);
    expect((hintTextWidget.style).color, const Color(0xdd000000));
    expect(
      (hintTextWidget.style).fontFamily,
      'SFPro',
    );
  } else {
    final hintTextFinder = find.descendant(
      of: textFieldFinder,
      matching: find.text('Search'),
    );
    expect(hintTextFinder, findsOneWidget);

    final hintTextWidget = tester.widget<Text>(hintTextFinder);

    final hintStyle = hintTextWidget.style;

    expect(hintStyle?.color, const Color(0x99000000));
    expect(hintStyle?.fontFamily, 'SFPro');
  }
}
