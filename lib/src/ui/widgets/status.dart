import 'package:flutter/material.dart';
import 'package:flutter_yoco/src/data/models/yoco_transaction.dart';

class FlutterYocoStatus extends StatelessWidget {
  const FlutterYocoStatus({super.key, required this.status});
  final YocoTransactionStatus status;

  ({String title, String message, String imagePath}) statusData() {
    switch (status) {
      case YocoTransactionStatus.success:
        return (
          title: 'Payment Successful',
          message: 'Great news! The payment was successful.',
          imagePath: 'assets/checked.png'
        );
      case YocoTransactionStatus.failed:
        return (
          title: 'Payment Failed',
          message: 'There was a problem while processing your payment',
          imagePath: 'assets/warning.png'
        );
      case YocoTransactionStatus.cancelled:
        return (
          title: 'Payment Cancelled',
          message: 'Your payment was cancelled',
          imagePath: 'assets/cancelled.png'
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            children: [
              SizedBox(
                height: 30,
                child: Image.asset(
                  'assets/yoc_logo.png',
                  package: "flutter_yoco",
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        SizedBox(
          height: 120,
          child: Image.network(statusData().imagePath),
        ),
        const SizedBox(height: 20),
        Text(
          statusData().title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Text(
            statusData().message,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: Colors.blueGrey.shade300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
