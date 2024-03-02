import 'package:unitedbiker/Packages/packages.dart';

Color homeScreenColor = const Color(0xff607D8B);
Color appBarColor = const Color(0xff607D8B);
Color secondaryPrimaryColor = const Color(0xffD9D9D9);
TextStyle montserratWhite = GoogleFonts.montserrat(
    color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600);
TextStyle montserratWhite2 = GoogleFonts.montserrat(
    color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600);
TextStyle montserratBlack = GoogleFonts.montserrat(
    color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600);
TextStyle montserrat12 = GoogleFonts.montserrat(
    color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
TextStyle montserrat17 = GoogleFonts.montserrat(
    color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600);
TextStyle montserrat12Blue = GoogleFonts.montserrat(
    color: appBarColor, fontSize: 15, fontWeight: FontWeight.w600);

bool loginScreen = true;
// classes objects
ScreenFunctions screenFunctions = ScreenFunctions();
DatabaseFunctions databaseFunctions = DatabaseFunctions();
WeatherFunction weatherFunction = WeatherFunction();
// controllers
TextEditingController weatherController = TextEditingController();
TextEditingController questionController = TextEditingController();
TextEditingController answerController = TextEditingController();
TextEditingController modelNumberController = TextEditingController();
TextEditingController companyNameController = TextEditingController();
TextEditingController bikeUsedTimeController = TextEditingController();
TextEditingController bikePriceController = TextEditingController();
TextEditingController bikeDescriptionController = TextEditingController();
TextEditingController bikeOwnerNumber = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();

//  variables
String bikeCategory = 'newbikes';

FirebaseAuth auth = FirebaseAuth.instance;
