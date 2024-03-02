import 'package:unitedbiker/Packages/packages.dart';

void showSnackbar(BuildContext context, Color? color, String message) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Text(
      message,
      style: montserratWhite,
    ),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
