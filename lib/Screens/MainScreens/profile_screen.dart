import 'package:unitedbiker/Packages/packages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showIndicator = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryPrimaryColor,
        appBar: appBar(
            auth.currentUser != null ? 'Profile Screen' : 'Login Screen',
            false,
            () => null),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileContainer('Fuel Consumption Calculator',
                    'assets/profileIcons/calculatorIcon.svg', () {}),
                profileContainer('Post in Community',
                    'assets/profileIcons/communityAskIcon.svg', () {
                  screenFunctions.nextScreen(
                      context, const AskInCommunityScreen());
                }),
                profileContainer(
                    'My Orders', 'assets/profileIcons/orderIcon.svg', () {
                  screenFunctions.nextScreen(context, const UserOrderScreen());
                }),
                profileContainer(
                    'List Your Bike', 'assets/profileIcons/listingIcon.svg',
                    () {
                  screenFunctions.nextScreen(
                    context,
                    const BikeListingScreen(),
                  );
                }),
                profileContainer('Logout', 'assets/profileIcons/exitIcon.svg',
                    () async {
                  await FirebaseAuth.instance.signOut();
                  showSnackbar(context, Colors.red, 'Logged Out');
                  setState(() {});
                  screenFunctions.nextScreen(context, Navigation());
                }),
              ],
            ),
          ),
        ));
  }

  profileContainer(String title, String iconPath, Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            color: const Color(0xffCCCCCC),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: montserrat12,
                ),
                SvgPicture.asset(iconPath)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
