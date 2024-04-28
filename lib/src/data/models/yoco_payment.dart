// dart format lib/src/models/yoco_payment.dart

class YocoPayment {
  final String id;
  final String redirectUrl;
  final String status;
  final int amount;
  final String currency;
  final String? paymentId;
  final String? successUrl;
  final String? cancelUrl;
  final String? failureUrl;
  final Metadata metadata;
  final String merchantId;
  final int? totalDiscount;
  final int? totalTaxAmount;
  final int? subtotalAmount;
  final List<dynamic>? lineItems;
  final String externalId;
  final String processingMode;

  YocoPayment({
    required this.id,
    required this.redirectUrl,
    required this.status,
    required this.amount,
    required this.currency,
    required this.externalId,
    required this.processingMode,
    required this.metadata,
    required this.merchantId,
    this.paymentId,
    this.successUrl,
    this.cancelUrl,
    this.failureUrl,
    this.totalDiscount,
    this.totalTaxAmount,
    this.subtotalAmount,
    this.lineItems,
  });

  factory YocoPayment.fromJson(Map<String, dynamic> json) {
    return YocoPayment(
      id: json['id'],
      redirectUrl: json['redirectUrl'],
      status: json['status'],
      amount: json['amount'],
      currency: json['currency'],
      paymentId: json['paymentId'],
      successUrl: json['successUrl'],
      cancelUrl: json['cancelUrl'],
      failureUrl: json['failureUrl'],
      metadata: Metadata.fromJson(json['metadata']),
      merchantId: json['merchantId'],
      totalDiscount: json['totalDiscount'],
      totalTaxAmount: json['totalTaxAmount'],
      subtotalAmount: json['subtotalAmount'],
      lineItems: json['lineItems'],
      externalId: json['externalId'],
      processingMode: json['processingMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'redirectUrl': redirectUrl,
      'status': status,
      'amount': amount,
      'currency': currency,
      'paymentId': paymentId,
      'successUrl': successUrl,
      'cancelUrl': cancelUrl,
      'failureUrl': failureUrl,
      'metadata': metadata.toJson(),
      'merchantId': merchantId,
      'totalDiscount': totalDiscount,
      'totalTaxAmount': totalTaxAmount,
      'subtotalAmount': subtotalAmount,
      'lineItems': lineItems,
      'externalId': externalId,
      'processingMode': processingMode,
    };
  }
}

class Metadata {
  final String checkoutId;
  final String paymentFacilitator;

  Metadata({
    required this.checkoutId,
    required this.paymentFacilitator,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      checkoutId: json['checkoutId'],
      paymentFacilitator: json['paymentFacilitator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkoutId': checkoutId,
      'paymentFacilitator': paymentFacilitator,
    };
  }
}
