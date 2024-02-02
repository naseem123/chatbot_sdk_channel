import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('when the value is true then the radio button is selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _RadioButtonTest(
        value: true,
        isDisabled: false,
        onChanged: (onChanged) {},
        color: Colors.black,
      ),
    );
    await tester.pumpAndSettle();
    final radioButtonFinder = find.byType(RadioButton);
    expect(radioButtonFinder, findsOneWidget);
    await expectLater(
      radioButtonFinder,
      matchesGoldenFile(
        Uri.file('goldens/radio_button_selected.png'),
      ),
    );
  });
  testWidgets('when the value is false then the radio button is unselected',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _RadioButtonTest(
        value: false,
        isDisabled: false,
        onChanged: (onChanged) {},
        color: Colors.black,
      ),
    );
    await tester.pumpAndSettle();
    final radioButtonFinder = find.byType(RadioButton);
    expect(radioButtonFinder, findsOneWidget);
    await expectLater(
      radioButtonFinder,
      matchesGoldenFile(
        Uri.file('goldens/radio_button_unselected.png'),
      ),
    );
  });
  testWidgets(
    'radio button test, unselected',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _RadioButtonTest(
          value: false,
          isDisabled: false,
          onChanged: (onChanged) {},
          color: Colors.black,
        ),
      );
      await tester.pumpAndSettle();
      final radioButtonFinder = find.byType(RadioButton);
      expect(radioButtonFinder, findsOneWidget);
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_unselected.png',
        ),
      );

      final inkWellFinder = find.byType(InkWell);

      final textFinder = find.byType(Text);
      final radioButtonTextFinder = find.descendant(
        of: inkWellFinder,
        matching: textFinder,
      );
      expect(radioButtonTextFinder, findsOneWidget);

      final radioButtonTextWidget = tester.widget<Text>(radioButtonTextFinder);

      expect(radioButtonTextWidget.data, 'Radio Button');

      final textStyle = radioButtonTextWidget.style;
      expect(
        textStyle?.color,
        Colors.black,
      );
    },
  );
  testWidgets(
    'radio button test, selected',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _RadioButtonTest(
          value: true,
          isDisabled: false,
          onChanged: (onChanged) {},
          color: Colors.black,
        ),
      );
      await tester.pumpAndSettle();
      final radioButtonFinder = find.byType(RadioButton);
      expect(radioButtonFinder, findsOneWidget);
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_selected.png',
        ),
      );

      final inkWellFinder = find.byType(InkWell);

      final textFinder = find.byType(Text);
      final radioButtonTextFinder = find.descendant(
        of: inkWellFinder,
        matching: textFinder,
      );
      expect(radioButtonTextFinder, findsOneWidget);

      final radioButtonTextWidget = tester.widget<Text>(radioButtonTextFinder);

      expect(radioButtonTextWidget.data, 'Radio Button');

      final textStyle = radioButtonTextWidget.style;
      expect(
        textStyle?.color,
        Colors.black,
      );
    },
  );
  testWidgets(
    'the radio button is unselected, user taps on it to make it selected',
    (WidgetTester tester) async {
      final selectedValue = ValueNotifier(false);
      await tester.pumpWidget(
        ValueListenableBuilder<bool>(
          valueListenable: selectedValue,
          builder: (context, value, _) {
            return _RadioButtonTest(
              value: value,
              isDisabled: false,
              onChanged: (bool value) {
                selectedValue.value = value;
              },
              color: Colors.black,
            );
          },
        ),
      );
      await tester.pumpAndSettle();
      final radioButtonFinder = find.byType(RadioButton);
      expect(radioButtonFinder, findsOneWidget);
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_unselected.png',
        ),
      );

      final inkWellFinder = find.byType(InkWell);

      final textFinder = find.byType(Text);
      final radioButtonTextFinder = find.descendant(
        of: inkWellFinder,
        matching: textFinder,
      );
      expect(radioButtonTextFinder, findsOneWidget);

      final radioButtonTextWidget = tester.widget<Text>(radioButtonTextFinder);

      expect(radioButtonTextWidget.data, 'Radio Button');

      final textStyle = radioButtonTextWidget.style;
      expect(
        textStyle?.color,
        Colors.black,
      );
      final iconButtonFinder = find.byType(IconButton);
      await tester.tap(iconButtonFinder);
      await tester.pumpAndSettle();
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_selected.png',
        ),
      );
    },
  );
  testWidgets(
    'the radio button is selected, user taps on it to make it unselected',
    (WidgetTester tester) async {
      final selectedValue = ValueNotifier(true);
      await tester.pumpWidget(
        ValueListenableBuilder<bool>(
          valueListenable: selectedValue,
          builder: (context, value, _) {
            return _RadioButtonTest(
              value: value,
              isDisabled: false,
              onChanged: (bool value) {
                selectedValue.value = value;
              },
              color: Colors.black,
            );
          },
        ),
      );
      await tester.pumpAndSettle();
      final radioButtonFinder = find.byType(RadioButton);
      expect(radioButtonFinder, findsOneWidget);
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_selected.png',
        ),
      );

      final inkWellFinder = find.byType(InkWell);

      final textFinder = find.byType(Text);
      final radioButtonTextFinder = find.descendant(
        of: inkWellFinder,
        matching: textFinder,
      );
      expect(radioButtonTextFinder, findsOneWidget);

      final radioButtonTextWidget = tester.widget<Text>(radioButtonTextFinder);

      expect(radioButtonTextWidget.data, 'Radio Button');

      final textStyle = radioButtonTextWidget.style;
      expect(
        textStyle?.color,
        Colors.black,
      );
      final iconButtonFinder = find.byType(IconButton);
      await tester.tap(iconButtonFinder);
      await tester.pumpAndSettle();
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_unselected.png',
        ),
      );
    },
  );

  testWidgets(
    'the radio button is unselected with disable property, user taps on it there is no change',
    (WidgetTester tester) async {
      final selectedValue = ValueNotifier(false);
      await tester.pumpWidget(
        ValueListenableBuilder<bool>(
          valueListenable: selectedValue,
          builder: (context, value, _) {
            return _RadioButtonTest(
              value: value,
              isDisabled: true,
              onChanged: (bool value) {
                selectedValue.value = value;
              },
              color: Colors.black,
            );
          },
        ),
      );
      await tester.pumpAndSettle();
      final radioButtonFinder = find.byType(RadioButton);
      expect(radioButtonFinder, findsOneWidget);
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_unselected.png',
        ),
      );

      final inkWellFinder = find.byType(InkWell);

      final textFinder = find.byType(Text);
      final radioButtonTextFinder = find.descendant(
        of: inkWellFinder,
        matching: textFinder,
      );
      expect(radioButtonTextFinder, findsOneWidget);

      final radioButtonTextWidget = tester.widget<Text>(radioButtonTextFinder);

      expect(radioButtonTextWidget.data, 'Radio Button');

      final textStyle = radioButtonTextWidget.style;
      expect(
        textStyle?.color,
        Colors.black,
      );
      final iconButtonFinder = find.byType(IconButton);
      await tester.tap(iconButtonFinder);
      await tester.pumpAndSettle();
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_unselected.png',
        ),
      );
    },
  );
  testWidgets(
    'the radio button is selected with disable property, user taps on it there is no change',
    (WidgetTester tester) async {
      final selectedValue = ValueNotifier(true);
      await tester.pumpWidget(
        ValueListenableBuilder<bool>(
          valueListenable: selectedValue,
          builder: (context, value, _) {
            return _RadioButtonTest(
              value: value,
              isDisabled: true,
              onChanged: (bool value) {
                selectedValue.value = value;
              },
              color: Colors.black,
            );
          },
        ),
      );
      await tester.pumpAndSettle();
      final radioButtonFinder = find.byType(RadioButton);
      expect(radioButtonFinder, findsOneWidget);
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_selected.png',
        ),
      );

      final inkWellFinder = find.byType(InkWell);

      final textFinder = find.byType(Text);
      final radioButtonTextFinder = find.descendant(
        of: inkWellFinder,
        matching: textFinder,
      );
      expect(radioButtonTextFinder, findsOneWidget);

      final radioButtonTextWidget = tester.widget<Text>(radioButtonTextFinder);

      expect(radioButtonTextWidget.data, 'Radio Button');

      final textStyle = radioButtonTextWidget.style;
      expect(
        textStyle?.color,
        Colors.black,
      );
      final iconButtonFinder = find.byType(IconButton);
      await tester.tap(iconButtonFinder);
      await tester.pumpAndSettle();
      await expectLater(
        radioButtonFinder,
        matchesGoldenFile(
          'goldens/radio_button_selected.png',
        ),
      );
    },
  );
}

class _RadioButtonTest extends StatelessWidget {
  const _RadioButtonTest({
    required this.value,
    required this.isDisabled,
    required this.onChanged,
    this.color,
  });

  final bool value;
  final bool isDisabled;
  final void Function(bool) onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      brightness: Brightness.light,
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.themeData,
          home: Material(
            color: Colors.white,
            child: RadioButton(
              value: value,
              isDisabled: isDisabled,
              onChanged: onChanged,
              label: Text(
                'Radio Button',
                style: TextStyle(color: color),
              ),
            ),
          ),
        );
      },
    );
  }
}
