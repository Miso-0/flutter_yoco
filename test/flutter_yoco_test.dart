import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_yoco/flutter_yoco.dart';
import 'package:flutter_yoco/src/models/yoco_transaction.dart';
import 'package:flutter_yoco/src/widgets/flutter_yoco_linear_loading_indicator.dart';

void main() {
  // Initialize a testWidgets function for running tests.
  testWidgets('FlutterYoco Widget Test', (WidgetTester tester) async {
    // Build the FlutterYoco widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterYoco(
            amount: 100.0,
            transactionId: 'txn_12345',
            secretKey: 'your_secret_key_here',
            successUrl: 'https://yourbackend.com/success',
            cancelUrl: 'https://yourbackend.com/cancel',
            failureUrl: 'https://yourbackend.com/failure',
            onComplete: (YocoTransaction transaction) {},
          ),
        ),
      ),
    );

    // Wait for animations to complete, if any.
    await tester.pumpAndSettle();

    // Test 1: Check if CircularProgressIndicator is shown initially.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Test 2: Check if FlutterYocoLinearLoadingIndicator is present.
    expect(find.byType(FlutterYocoLinearLoadingIndicator), findsOneWidget);

    // Add more tests as needed.
  });
}
