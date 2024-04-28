# FlutterYoco: Simplified Yoco Payment Integration in Flutter

> Yoco offers you the quickest and easiest way to process card payments - both in-person, and on your online store. The Yoco Developers site details how to integrate your apps, stores or systems to process payments.

> **Note**: This package is not officially affiliated with Yoco. All Yoco images and trademarks are property of Yoco.

## Table of Contents

1. [Disclaimer](#disclaimer)
2. [Overview](#overview)
3. [Features](#features)
4. [Installation](#installation)
5. [Usage](#usage)
    - [Basic Example](#basic-example)
    - [Advanced Configuration](#advanced-configuration)
6. [API](#api)
7. [Transaction Statuses](#transaction-statuses)
8. [Contributing](#contributing)
9. [Support](#support)
10. [License](#license)

## Disclaimer

Yoco advises against using the `successUrl`, `cancelUrl`, and `failureUrl` to determine the status of a payment. However, this package utilizes them to update the UI accordingly. For secure and accurate payment status handling, it is highly advised to set up a backend service. For more details, consult [Yoco's official documentation](https://developer.yoco.com/online/api-reference/checkout/getting-started).

## Overview

The `FlutterYoco` widget provides an easy-to-use interface for integrating Yoco payments within your Flutter applications. Using a web view, it handles the payment process and allows for extensive customization.

## Features

- **Easy Initialization**: Minimal setup with required parameters.
- **In-App Payment**: Built-in WebView for a seamless payment process.

## Requirements

|             | Android        | iOS   |
|-------------|----------------|-------|
| **Support** | SDK 19+ or 20+ | 11.0+ |

```groovy
android {
    defaultConfig {
        minSdkVersion 19
    }
}
```

## Installation

To get started, add `flutter_yoco` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
flutter_yoco: ^latest_version
```

Run `flutter pub get` to install the package.

## Installation

To get started, you'll need to import the required modules:

```dart
import 'package:flutter_yoco/flutter_yoco.dart';
```

## Usage

### Basic Example

Include the `FlutterYoco` widget within your widget tree like so:

```dart
FlutterYoco(
  amount: 100.00,
  transactionId: 'txn_12345',
  secretKey: 'your_secret_key_here',
  successUrl: 'https://yourbackend.com/success/',
  cancelUrl: 'https://yourbackend.com/cancel/',
  failureUrl: 'https://yourbackend.com/failure/',
  onComplete: (YocoTransaction transaction) {
    // Handle the transaction outcome.
  },
)
```

### Advanced Configuration

You can further customize the behavior by using additional optional parameters. (To be detailed here if any)

## API

| Parameter       | Type    | Required | Description                                                             |
| --------------- | ------- | -------- | ----------------------------------------------------------------------- |
| `amount`        | double  | Yes      | The payment amount, specified in Rands.                                  |
| `transactionId` | String  | Yes      | A unique identifier for each transaction.                                |
| `secretKey`     | String  | Yes      | Your Yoco account's secret key.                                          |
| `successUrl`    | String  | Yes      | URL to handle successful payments.                                       |
| `cancelUrl`     | String  | Yes      | URL to handle cancelled payments.                                        |
| `failureUrl`    | String  | Yes      | URL to handle failed payments.                                           |
| `onComplete`    | Function| No       | Callback function triggered when the payment process is complete.        |

## Transaction Statuses

The `FlutterYoco` widget recognizes the following transaction statuses:

- `YocoTransactionStatus.Success`
- `YocoTransactionStatus.Cancelled`
- `YocoTransactionStatus.Failed`

These statuses trigger the `onComplete` callback, if specified, and are used for UI updates.

## License

Refer to the project's license for terms of use.
