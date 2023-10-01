// Copyright 2023 Miso Menze
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.
// import 'dart:convert';
// ignore_for_file: must_be_immutable, unused_element

// dart format lib/src/widgets/flutter_yoco_linear_loading_indicator.dart

import 'package:flutter/material.dart';

class FlutterYocoLinearLoadingIndicator extends StatelessWidget {
  const FlutterYocoLinearLoadingIndicator({
    super.key,
    required this.progress,
  });

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
