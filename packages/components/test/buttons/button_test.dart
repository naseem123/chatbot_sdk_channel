import 'package:components/src/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resources/resources.dart';

void main() {
  testWidgets('Default Button, default test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _defaultButton(
        ButtonState.active,
        Brightness.light,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xff000000),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0xffedefe0),
    );
  });

  testWidgets('Default Button, disabled test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _defaultButton(
        ButtonState.disabled,
        Brightness.light,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xff696969),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0xff8f8f8f),
    );
  });

  testWidgets('Default Button, loading test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _defaultButton(
        ButtonState.loading,
        Brightness.light,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xff000000),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
    );
  });

  testWidgets('Default-White Button, default test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _defaultButton(
        ButtonState.active,
        Brightness.dark,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xffedefe0),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0xff000000),
    );
  });

  testWidgets('Default-White Button, disabled test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _defaultButton(
        ButtonState.disabled,
        Brightness.dark,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xffedefe0),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0x29000000),
    );
  });

  testWidgets('Default-White Button, loading test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _defaultButton(
        ButtonState.loading,
        Brightness.dark,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xffedefe0),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
    );
  });

  testWidgets('Accent Button, default test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _accentButton(
        ButtonState.active,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xff5038ff),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0xffedefe0),
    );
  });

  testWidgets('Accent Button, disabled test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _accentButton(
        ButtonState.disabled,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xffaba6eb),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0x66ffffff),
    );
  });

  testWidgets('Accent Button, loading test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _accentButton(
        ButtonState.loading,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xff5038ff),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
    );
  });

  testWidgets('Destructive Button, default test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _destructiveButton(
        ButtonState.active,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xffa80700),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0xffedefe0),
    );
  });

  testWidgets('Destructive Button, disabled test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _destructiveButton(
        ButtonState.disabled,
      ),
    );
    expectationForButton(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xffdda6a4),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
      textStyleColor: const Color(0x8fffffff),
    );
  });

  testWidgets('Destructive Button, loading test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _destructiveButton(
        ButtonState.loading,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: ElevatedButton,
      tester: tester,
      backgroundColor: const Color(0xffa80700),
      borderStyle: BorderStyle.none,
      borderColor: const Color(0xff000000),
    );
  });

  testWidgets('Secondary Button, default test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryButton(
        ButtonState.active,
      ),
    );
    expectationForButton(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0x1f000000),
      textStyleColor: const Color(0xff000000),
    );
  });

  testWidgets('Secondary Button, disabled test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryButton(
        ButtonState.disabled,
      ),
    );
    expectationForButton(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0x1f000000),
      textStyleColor: const Color(0xffcccccc),
    );
  });

  testWidgets('Secondary Button, loading test', (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryButton(
        ButtonState.loading,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0x1f000000),
    );
  });

  testWidgets('Secondary-White Button, default test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryWhiteButton(
        ButtonState.active,
      ),
    );
    expectationForButton(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0xffedefe0),
      textStyleColor: const Color(0xffedefe0),
    );
  });

  testWidgets('Secondary-White Button, disabled test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryWhiteButton(
        ButtonState.disabled,
      ),
    );
    expectationForButton(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0x52edefe0),
      textStyleColor: const Color(0x52edefe0),
    );
  });

  testWidgets('Secondary-White Button, loading test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryWhiteButton(
        ButtonState.loading,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0xffedefe0),
    );
  });

  testWidgets('Secondary Button with icon, default test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryButtonWithIcon(
        ButtonState.active,
      ),
    );
    expectationForButtonWithIcon(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderColor: const Color(0x1f000000),
      textStyleColor: const Color(0xff000000),
    );
  });

  testWidgets('Secondary Button with icon, disabled test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryButtonWithIcon(
        ButtonState.disabled,
      ),
    );
    expectationForButtonWithIcon(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderColor: const Color(0x1f000000),
      textStyleColor: const Color(0xffcccccc),
    );
  });

  testWidgets('Secondary Button with icon, loading test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryButtonWithIcon(
        ButtonState.loading,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0x1f000000),
    );
  });

  testWidgets('Secondary-White Button with Icon, default test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryWhiteButtonWithIcon(
        ButtonState.active,
      ),
    );
    expectationForButtonWithIcon(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderColor: const Color(0xffedefe0),
      textStyleColor: const Color(0xffedefe0),
    );
  });

  testWidgets('Secondary-White Button with Icon, disabled test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryWhiteButtonWithIcon(
        ButtonState.disabled,
      ),
    );
    expectationForButtonWithIcon(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderColor: const Color(0x52edefe0),
      textStyleColor: const Color(0x52edefe0),
    );
  });

  testWidgets('Secondary-White Button with Icon, loading test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _secondaryWhiteButtonWithIcon(
        ButtonState.loading,
      ),
    );
    expectationForButtonWithButtonStateLoading(
      buttonType: OutlinedButton,
      tester: tester,
      backgroundColor: const Color(0x00000000),
      borderStyle: BorderStyle.solid,
      borderColor: const Color(0xffedefe0),
    );
  });
}

Widget _defaultButton(ButtonState buttonState, Brightness brightness) {
  return AppTheme(
    builder: (BuildContext context) {
      return MaterialApp(
        theme: context.themeData,
        home: Material(
          color: brightness == Brightness.light ? Colors.white : Colors.black,
          child: Button(
            state: buttonState,
            onPressed: () {},
            child: const Text('Button'),
          ),
        ),
      );
    },
    brightness: brightness,
  );
}

Widget _accentButton(ButtonState buttonState) {
  return AppTheme(
    builder: (BuildContext context) {
      return MaterialApp(
        theme: context.themeData,
        home: Button.accent(
          state: buttonState,
          onPressed: () {},
          child: const Text('Button'),
        ),
      );
    },
    brightness: Brightness.light,
  );
}

Widget _destructiveButton(ButtonState buttonState) {
  return AppTheme(
    builder: (BuildContext context) {
      return MaterialApp(
        theme: context.themeData,
        home: Button.destructive(
          state: buttonState,
          onPressed: () {},
          child: const Text('Button'),
        ),
      );
    },
    brightness: Brightness.light,
  );
}

Widget _secondaryButton(ButtonState buttonState) {
  return AppTheme(
    builder: (BuildContext context) {
      return MaterialApp(
        theme: context.themeData,
        home: Material(
          color: Colors.white,
          child: Button.secondary(
            state: buttonState,
            onPressed: () {},
            child: const Text('Button'),
          ),
        ),
      );
    },
    brightness: Brightness.light,
  );
}

Widget _secondaryWhiteButton(ButtonState buttonState) {
  return AppTheme(
    builder: (BuildContext context) {
      return MaterialApp(
        theme: context.themeData,
        home: Material(
          color: Colors.white,
          child: Button.secondaryWhite(
            state: buttonState,
            onPressed: () {},
            child: const Text('Button'),
          ),
        ),
      );
    },
    brightness: Brightness.light,
  );
}

Widget _secondaryButtonWithIcon(ButtonState buttonState) {
  return AppTheme(
    builder: (BuildContext context) {
      return MaterialApp(
        theme: context.themeData,
        home: Material(
          color: Colors.white,
          child: Button.secondary(
            icon: const Icon(Icons.add_circle_outline),
            state: buttonState,
            onPressed: () {},
            child: const Text('Button'),
          ),
        ),
      );
    },
    brightness: Brightness.light,
  );
}

Widget _secondaryWhiteButtonWithIcon(ButtonState buttonState) {
  return AppTheme(
    builder: (BuildContext context) {
      return MaterialApp(
        theme: context.themeData,
        home: Material(
          color: Colors.white,
          child: Button.secondaryWhite(
            icon: const Icon(Icons.add_circle_outline),
            state: buttonState,
            onPressed: () {},
            child: const Text('Button'),
          ),
        ),
      );
    },
    brightness: Brightness.light,
  );
}

void expectationForButton({
  required Type buttonType,
  required WidgetTester tester,
  required Color backgroundColor,
  required BorderStyle borderStyle,
  required Color borderColor,
  required Color textStyleColor,
}) {
  final buttonFinder = find.byType(buttonType);
  final buttonMaterial = find.descendant(
    of: buttonFinder,
    matching: find.byType(Material),
  );
  final material = tester.widget<Material>(buttonMaterial);
  expect(
    material.color,
    backgroundColor,
  );

  final border = material.shape! as OutlinedBorder;
  final textStyle = material.textStyle;

  expect(border.side.style, borderStyle);
  expect(
    border.side.width,
    borderStyle == BorderStyle.solid ? 1.0 : 0.0,
  );
  expect(border.side.color, borderColor);

  final textFinder = find.descendant(
    of: buttonFinder,
    matching: find.text('Button'),
  );
  expect(textFinder, findsOneWidget);

  expect(textStyle?.fontFamily, 'SFPro');
  expect(textStyle?.color, textStyleColor);
}

void expectationForButtonWithButtonStateLoading({
  required Type buttonType,
  required WidgetTester tester,
  required Color backgroundColor,
  required BorderStyle borderStyle,
  required Color borderColor,
}) {
  final buttonFinder = find.byType(buttonType);
  final buttonMaterial = find.descendant(
    of: buttonFinder,
    matching: find.byType(Material),
  );
  final material = tester.widget<Material>(buttonMaterial);
  expect(
    material.color,
    backgroundColor,
  );

  final border = material.shape! as OutlinedBorder;

  expect(border.side.style, borderStyle);
  expect(
    border.side.width,
    borderStyle == BorderStyle.solid ? 1.0 : 0.0,
  );
  expect(border.side.color, borderColor);

  final circularLoadingFinder = find.descendant(
    of: buttonFinder,
    matching: find.byType(CircularProgressIndicator),
  );
  expect(circularLoadingFinder, findsOneWidget);
}

void expectationForButtonWithIcon({
  required Type buttonType,
  required WidgetTester tester,
  required Color backgroundColor,
  required Color borderColor,
  required Color textStyleColor,
}) {
  final buttonFinder = find.byType(buttonType);
  final buttonMaterial = find.descendant(
    of: buttonFinder,
    matching: find.byType(Material),
  );
  final material = tester.widget<Material>(buttonMaterial);
  expect(
    material.color,
    backgroundColor,
  );

  final border = material.shape! as OutlinedBorder;
  final textStyle = material.textStyle;

  expect(border.side.style, BorderStyle.solid);
  expect(border.side.width, 1.0);
  expect(border.side.color, borderColor);

  final iconFinder = find.descendant(
    of: buttonFinder,
    matching: find.byIcon(Icons.add_circle_outline),
  );
  expect(iconFinder, findsOneWidget);

  final textFinder = find.descendant(
    of: buttonFinder,
    matching: find.text('Button'),
  );
  expect(textFinder, findsOneWidget);

  expect(textStyle?.fontFamily, 'SFPro');
  expect(textStyle?.color, textStyleColor);
}
