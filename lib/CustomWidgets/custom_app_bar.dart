import 'package:unitedbiker/Packages/packages.dart';

appBar(String title, bool button, Function()? onTap) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    backgroundColor: appBarColor,
    title: Text(
      title,
      style: montserratWhite,
    ),
    actions: [
      button
          ? GestureDetector(
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
              ),
            )
          : Container()
    ],
  );
}
