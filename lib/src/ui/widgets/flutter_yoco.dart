import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yoco/src/ui/controllers/flutter_yoco_controller.dart';
import 'package:flutter_yoco/src/types/yoco_payment.dart';
import 'package:flutter_yoco/src/types/yoco_transaction.dart';
import 'package:flutter_yoco/src/ui/widgets/status.dart';
import 'package:flutter_yoco/src/ui/widgets/web_view.dart';

// dart format lib/src/widgets/flutter_yoco.dart

/// A widget that handles the entire payment process.
///
/// This uses a 'webview_flutter' to display the payment page.
///
class FlutterYoco extends StatefulWidget {
  const FlutterYoco({
    super.key,
    required this.secretKey,
    required this.amount,
    required this.transactionId,
    required this.successUrl,
    required this.cancelUrl,
    required this.failureUrl,
    this.onComplete,
  });

  ///This is the amount in rands
  ///
  final double amount;

  ///This is the transaction id
  ///This is used as an external id on Yoco to identify the transaction
  ///
  final String transactionId;

  ///All these urls should be from your backend
  ///
  ///which will handle the payment results, for the respective status
  final String successUrl;
  final String cancelUrl;
  final String failureUrl;

  ///This is the secret key from your Yoco account
  ///
  final String secretKey;

  ///This is the callback function that will be called when the payment is complete
  ///And the status of the payment will be passed as an argument
  ///as well as the payment details
  ///
  final void Function(YocoTransaction transaction)? onComplete;

  @override
  State<FlutterYoco> createState() => _FlutterYocoState();
}

class _FlutterYocoState extends State<FlutterYoco> {
  ///This is the controller will be used to initialize the webview
  FlutterYocoController? _controller;

  ///This is the status of the payment
  YocoTransactionStatus? _status;

  ///This is the progress for loading the webview
  int progress = 0;

  ///This function checks if the urls are valid
  void setStatus(YocoTransactionStatus status) {
    setState(() {
      _status = status;
      if (kDebugMode) {
        print('Flutter_yoco: Status: $_status');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initialize();
    });
  }

  Future<void> _initialize() async {
    try {
      _controller = FlutterYocoController(
        widget: widget,
        onProgress: (int progress) {
          if (kDebugMode) {
            print('Flutter_yoco: Progress: $progress');
          }
        },
        onUrlStarted: (String url, YocoPayment payment) =>
            handleUrlChange(url, payment),
      );
      await _controller!.init();
    } catch (e) {
      throw Exception(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Linear loading indicator reflecting current transaction progress.
          _LoadingIndicator(progress: progress),

          // Conditional logic to decide what to show based on the state.

          // Case 1: Show a circular progress indicator when both _controller and _status are null.
          if (_controller == null && _status == null)
            const Padding(
              padding: EdgeInsets.only(top: 100),
              // A CircularProgressIndicator to indicate that something is loading.
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 6,
              ),
            )

          // Case 2: Show the WebView when _controller is not null but _status is null.
          else if (_controller != null && _status == null)
            // WebView to handle the transaction process.
            FlutterYocoWebView(yocoController: _controller!)

          // Case 3: Show transaction status when _status is not null.
          else
            // Display the status of the transaction (success, failure, cancelled).
            FlutterYocoStatus(status: _status!)
        ],
      ),
    );
  }

// Function to handle changes in URL during a transaction.
  void handleUrlChange(String url, YocoPayment payment) {
    // Trimming and comparing URLs to determine transaction outcome.
    final isSuccess = url.trim() == widget.successUrl;
    final isCancel = url.trim() == widget.cancelUrl;
    final isFailure = url.trim() == widget.failureUrl;

    // Handling successful transaction.
    if (isSuccess) {
      // Set the transaction status as 'success'.
      const status = YocoTransactionStatus.success;
      setStatus(status); // Update the status in the state.

      // Create a new transaction object.
      final transaction = YocoTransaction(
        status: status,
        payment: payment,
      );

      // Call the optional 'onComplete' callback if provided.
      if (widget.onComplete != null) {
        widget.onComplete!(transaction);
      }
    }

    // Handling cancelled transaction.
    else if (isCancel) {
      // Set the transaction status as 'cancelled'.
      const status = YocoTransactionStatus.cancelled;
      setStatus(status); // Update the status in the state.

      // Create a new transaction object.
      final transaction = YocoTransaction(
        status: status,
        payment: payment,
      );

      // Call the optional 'onComplete' callback if provided.
      if (widget.onComplete != null) {
        widget.onComplete!(transaction);
      }
    }

    // Handling failed transaction.
    else if (isFailure) {
      // Set the transaction status as 'failed'.
      const status = YocoTransactionStatus.failed;
      setStatus(status); // Update the status in the state.

      // Create a new transaction object.
      final transaction = YocoTransaction(
        status: status,
        payment: payment,
      );

      // Call the optional 'onComplete' callback if provided.
      if (widget.onComplete != null) {
        widget.onComplete!(transaction);
      }
    }
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({required this.progress});
  final int progress;
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress / 100,
      backgroundColor: Colors.transparent,
      color: Colors.blue,
    );
  }
}
