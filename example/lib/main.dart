import 'package:flutter/material.dart';
import 'package:flutter_yoco/flutter_yoco.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            FlutterYoco(
              secretKey: '',
              amount: 100.00,
              transactionId: 1000070.toString(),
              successUrl: 'https://misomenze.info/success/',
              cancelUrl: 'https://misomenze.info/cancel/',
              failureUrl: 'https://misomenze.info/failure/',
              onComplete: (transaction) {
                print('Completed: ${transaction.toJson()}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
