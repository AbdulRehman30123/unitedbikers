import 'package:unitedbiker/Packages/packages.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 2;
  List<Widget?> screens = [
    const VehicleVerificationScreen(),
    const WeatherScreen(),
    const HomeScreen(),
    const CommunityScreen(),
    auth.currentUser != null
        ? const ProfileScreen()
        : AuthScreen(
            fromProductPage: false,
          )
  ];
  Widget? selectedScreen;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              navSizeBox(
                width,
                'assets/profileIcons/vehicleVerificationIcon.svg',
                'Verification',
                0,
              ),
              navSizeBox(
                width,
                'assets/navIcons/weatherIcon.svg',
                'Weather',
                1,
              ),
              navSizeBox(
                width,
                'assets/navIcons/homeIcon.svg',
                'Home',
                2,
              ),
              navSizeBox(
                width,
                'assets/navIcons/communityIcon.svg',
                'Community',
                3,
              ),
              navSizeBox(
                width,
                'assets/navIcons/profile.svg',
                'Profile',
                4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navSizeBox(
    double width,
    String assetName,
    String title,
    int index,
  ) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 70,
        width: width / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetName,
              color: selectedIndex == index
                  ? appBarColor // Change to your desired color
                  : const Color(0xff000000),
              width: 20,
              height: 25,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 8,
                color: selectedIndex == index
                    ? appBarColor // Change to your desired color
                    : const Color(0xff000000),
              ),
            )
          ],
        ),
      ),
    );
  }
}
