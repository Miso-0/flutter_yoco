// Copyright 2023 Miso Menze
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.
// import 'dart:convert';
// ignore_for_file: must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_yoco/src/controllers/flutter_yoco_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

// dart format lib/src/widgets/flutter_yoco_web_view.dart

/// A webview widget that paints the payment page.
class FlutterYocoWebView extends StatelessWidget {
  const FlutterYocoWebView({super.key, required this.yocoController});

  final FlutterYocoController yocoController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WebViewWidget(
        controller: yocoController.controller,
      ),
    );
  }
}
