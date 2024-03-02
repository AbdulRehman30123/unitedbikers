import 'package:unitedbiker/Packages/packages.dart';

customTextField(String hintText, TextEditingController controller,
    Function()? onTap, bool buttonShow) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      style: montserratWhite,
      controller: controller,
      decoration: InputDecoration(
          fillColor: appBarColor,
          suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buttonShow
                  ? GestureDetector(
                      onTap: onTap,
                      child: SvgPicture.asset(
                        'assets/sendIcon.svg',
                        // ignore: deprecated_member_use
                        color: Colors.white,
                      ),
                    )
                  : null),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 15.0), // Adjust padding as needed
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
          ),
          hintText: hintText,
          hintStyle: montserratWhite),
    ),
  );
}
