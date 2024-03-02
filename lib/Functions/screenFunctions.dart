// ignore_for_file: deprecated_member_use

import 'package:unitedbiker/Packages/packages.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenFunctions {
  nextScreen(context, screenName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  }

  popScreen(context) {
    Navigator.pop(context);
  }

  void openWhatsAppChat(String phoneNumber) async {
    // Check if WhatsApp is installed
    var phone = phoneNumber;
    var url = 'https://wa.me/$phone';
    await launch(url);
  }
}
