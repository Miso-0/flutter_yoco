import 'package:flutter_yoco/src/models/yoco_payment.dart';

// dart format lib/src/models/yoco_transaction.dart
enum YocoTransactionStatus {
  success,
  failed,
  cancelled,
}

class YocoTransaction {
  final YocoTransactionStatus status;
  final YocoPayment payment;

  YocoTransaction({
    required this.status,
    required this.payment,
  });

  YocoTransaction copyWith({
    YocoTransactionStatus? status,
    YocoPayment? payment,
  }) {
    return YocoTransaction(
      status: status ?? this.status,
      payment: this.payment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'payment': payment.toJson(),
    };
  }
}
