import 'package:flutter/material.dart';
import 'package:flutter_yoco/src/models/yoco_transaction.dart';

// dart format lib/src/widgets/flutter_yoco_status.dart

class FlutterYocoStatus extends StatelessWidget {
  const FlutterYocoStatus({super.key, required this.status});
  final YocoTransactionStatus status;

  ({String title, String message, String imagePath}) statusData() {
    switch (status) {
      case YocoTransactionStatus.success:
        return (
          title: 'Payment Successful',
          message: 'Great news! The payment was successful.',
          imagePath:
              'https://firebasestorage.googleapis.com/v0/b/flutter-ozow.appspot.com/o/yoco%2Fchecked.png?alt=media&token=c66a7e0a-869b-4847-a762-37425fdd915d&_gl=1*1ic2ofv*_ga*MTg2MTI0OTAxMy4xNjUzOTAwNTU3*_ga_CW55HF8NVT*MTY5NjExMDU3Ny4zNS4xLjE2OTYxMTA2MjguOS4wLjA.'
        );
      case YocoTransactionStatus.failed:
        return (
          title: 'Payment Failed',
          message: 'There was a problem while processing your payment',
          imagePath:
              "https://firebasestorage.googleapis.com/v0/b/flutter-ozow.appspot.com/o/yoco%2Fwarning.png?alt=media&token=dcbbdc7f-6aef-4aab-bf56-0f7b3e0dd291&_gl=1*1ddlsn6*_ga*MTg2MTI0OTAxMy4xNjUzOTAwNTU3*_ga_CW55HF8NVT*MTY5NjExMDU3Ny4zNS4xLjE2OTYxMTA3NDAuMTYuMC4w"
        );
      case YocoTransactionStatus.cancelled:
        return (
          title: 'Payment Cancelled',
          message: 'Your payment was cancelled',
          imagePath:
              'https://firebasestorage.googleapis.com/v0/b/flutter-ozow.appspot.com/o/yoco%2Fcancelled.png?alt=media&token=3b1baba2-cb28-4b98-bbe7-baa8da916e99&_gl=1*oi83rf*_ga*MTg2MTI0OTAxMy4xNjUzOTAwNTU3*_ga_CW55HF8NVT*MTY5NjExMDU3Ny4zNS4xLjE2OTYxMTA2OTYuNjAuMC4w'
        );
    }
  }

  final logo =
      'https://firebasestorage.googleapis.com/v0/b/flutter-ozow.appspot.com/o/yoco%2Fyoc_logo.png?alt=media&token=3e1f2272-e987-4c5c-8cf8-3e468f2ad293&_gl=1*ej23py*_ga*MTg2MTI0OTAxMy4xNjUzOTAwNTU3*_ga_CW55HF8NVT*MTY5NjExMDU3Ny4zNS4xLjE2OTYxMTEwMDQuNTEuMC4w';

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
                child: Image.network(logo),
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
