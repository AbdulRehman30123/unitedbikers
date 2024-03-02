import 'package:unitedbiker/Packages/packages.dart';

class AuthScreen extends StatefulWidget {
  bool fromProductPage;
  AuthScreen({super.key, required this.fromProductPage});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loginScreen = true;
  bool showIndicator = false;

  void validateAndPerformAction() {
    if (loginScreen) {
      if (emailController.text.isEmpty || passController.text.isEmpty) {
        showSnackbar(context, Colors.red, 'Please fill in all fields');
      } else {
        setState(() {
          showIndicator = true;
        });
        databaseFunctions.loginUser(emailController.text, passController.text,
            context, widget.fromProductPage);
        setState(() {
          showIndicator = false;
        });
      }
    } else {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passController.text.isEmpty) {
        showSnackbar(context, Colors.red, 'Please fill in all fields');
      } else {
        setState(() {
          showIndicator = true;
        });
        databaseFunctions.createUser(emailController.text, passController.text,
            nameController.text, context, widget.fromProductPage);
        setState(() {
          showIndicator = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          loginScreen ? 'Login Screen' : 'Sign Up Screen', false, () => null),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginScreen
                ? const SizedBox()
                : customTextField('Name', nameController, () {}, false),
            customTextField('Email', emailController, () {}, false),
            customTextField('Password', passController, () {}, false),
            GestureDetector(
              onTap: validateAndPerformAction,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      loginScreen ? 'Login' : 'Sign Up',
                      style: montserratWhite,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  loginScreen = !loginScreen;
                });
                print(loginScreen);
              },
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: loginScreen
                          ? "Don't have an account "
                          : 'Already have an Account ',
                      style: const TextStyle(
                        color: Colors.black, fontSize: 10,
                        decoration: TextDecoration.none,
                        // Add other styles as needed
                      ),
                    ),
                    TextSpan(
                      text: loginScreen ? 'Sign up now!' : 'Login Now',
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xff607D8B),
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                          // Add other styles as needed
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
