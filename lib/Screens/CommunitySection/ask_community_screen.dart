import 'package:unitedbiker/Packages/packages.dart';

class AskInCommunityScreen extends StatefulWidget {
  const AskInCommunityScreen({super.key});

  @override
  State<AskInCommunityScreen> createState() => _AskInCommunityScreenState();
}

class _AskInCommunityScreenState extends State<AskInCommunityScreen> {
  String? userName;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Ask Community', false, () => null),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add a multiline text field
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFEDEDED), // Filled color #F5F4F4
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: questionController,
                          maxLines: null, // Allows for multiline input
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ask Question',
                            hintStyle: GoogleFonts.lato(
                              color: const Color(0xff404040),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              screenFunctions.popScreen(context);
                            },
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
                                    'Cancel',
                                    style: montserratWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (questionController.text.isEmpty) {
                                showSnackbar(context, Colors.red,
                                    'Please fill in field');
                              } else {
                                databaseFunctions.postQuestion(
                                    questionController.text,
                                    userName!,
                                    auth.currentUser!.uid,
                                    context);
                              }
                            },
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
                                    'Ask Question',
                                    style: montserratWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  getUserData() async {
    var uId = auth.currentUser!.uid;
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    DocumentSnapshot<Object?> userDocSnapshot =
        await usersCollection.doc(uId).get();
    userName = userDocSnapshot.get('name');
    print(userName);
  }
}
