import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apkrover/main.dart';

void main() {
  testWidgets('Dashboard shows AppBar, Drawer icon and MQTT card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const RoverApp());
    await tester.pumpAndSettle();

    // AppBar ada
    expect(find.byType(AppBar), findsOneWidget);

    // Title sesuai
    expect(find.text('R.O.V.E.R Monitoring'), findsOneWidget);

    // Drawer (hamburger) — by Tooltip
    expect(find.byTooltip('Open navigation menu'), findsOneWidget);

    // Salah satu IoTCard (MQTT) muncul
    expect(find.text('MQTT'), findsOneWidget);
    expect(find.text('Connected'), findsOneWidget);
  });
}
