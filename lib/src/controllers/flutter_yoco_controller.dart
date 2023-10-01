import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_yoco/src/models/yoco_payment.dart';
import 'package:flutter_yoco/src/widgets/flutter_yoco.dart';
import 'package:webview_flutter/webview_flutter.dart';

// dart format lib/src/controllers/flutter_yoco_controller.dart

class FlutterYocoController {
  final FlutterYoco widget;
  final void Function(int progress) onProgress;
  final void Function(String url, YocoPayment transaction) onUrlStarted;
  late final WebViewController _controller;

  FlutterYocoController({
    required this.widget,
    required this.onProgress,
    required this.onUrlStarted,
  });

  Future<void> init() async {
    if (kDebugMode) {
      print('Flutter_yoco: Initializing controller...');
    }

    if (!isValidUrls()) {
      if (kDebugMode) {
        print('Flutter_yoco: initialization failed, urls are equal');
      }
      throw Exception('Urls cannot be equal');
    }

    if (!endsWithSlash(widget.successUrl) ||
        !endsWithSlash(widget.cancelUrl) ||
        !endsWithSlash(widget.failureUrl)) {
      if (kDebugMode) {
        print(
            'Flutter_yoco: initialization failed, urls must end with a slash');
      }
      throw Exception('Urls must end with a slash');
    }

    /// Create payment
    final payment = await createPayment();

    if (payment == null) {
      throw Exception('Payement could not be created');
    }

    _controller = _initController(payment);
  }

  WebViewController get controller => _controller;

  /// Initializes the controller.
  WebViewController _initController(YocoPayment payment) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) => onProgress(progress),
          onUrlChange: (UrlChange change) {
            if (kDebugMode) {
              print('Flutter_ozow: Url changed: ${change.url}');
            }
          },
          onPageStarted: (String url) {
            if (kDebugMode) {
              print('Flutter_ozow: Page started loading: $url');
            }
            onUrlStarted(url, payment);
          },
          onPageFinished: (String url) {
            if (kDebugMode) {
              print('Flutter_ozow: Page finished loading');
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (kDebugMode) {
              print('Flutter_ozow: Error loading page: ${error.description}');
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          payment.redirectUrl,
        ),
      );
  }

  Future<YocoPayment?> createPayment() async {
    final dio = Dio();
    final body = {
      "amount": widget.amount,
      "currency": "ZAR",
      "externalId": widget.transactionId,
      "successUrl": widget.successUrl,
      "cancelUrl": widget.cancelUrl,
      "failureUrl": widget.failureUrl,
    };

    dio.options.headers["Authorization"] = "Bearer ${widget.secretKey}";
    dio.options.headers["Content-Type"] = "application/json";

    try {
      final response = await dio.post(
        "https://payments.yoco.com/api/checkouts",
        data: body,
      );

      final payment = YocoPayment.fromJson(response.data);

      return payment;
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Ensure that the urls are not equal
  ///
  bool isValidUrls() {
    return widget.successUrl != widget.cancelUrl &&
        widget.successUrl != widget.failureUrl &&
        widget.cancelUrl != widget.failureUrl;
  }

  ///
  bool endsWithSlash(String url) {
    return url.endsWith('/');
  }
}
