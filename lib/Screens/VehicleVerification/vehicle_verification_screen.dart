import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:unitedbiker/Packages/packages.dart';

class VehicleVerificationScreen extends StatefulWidget {
  const VehicleVerificationScreen({Key? key}) : super(key: key);

  @override
  State<VehicleVerificationScreen> createState() =>
      _VehicleVerificationScreenState();
}

class _VehicleVerificationScreenState extends State<VehicleVerificationScreen> {
  // initialize web controller
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse('https://www.gari.pk/mtmis-online-vehicle-verification/'),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('Vehicle Verification', false, () => null),
        body: WebViewWidget(controller: controller));
  }
}
