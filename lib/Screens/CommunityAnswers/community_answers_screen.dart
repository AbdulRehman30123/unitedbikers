import 'package:unitedbiker/Packages/packages.dart';

class AnswersScreen extends StatefulWidget {
  final String questionDocumentId;
  final String id;
  const AnswersScreen(
      {required this.questionDocumentId, required this.id, Key? key})
      : super(key: key);

  @override
  State<AnswersScreen> createState() => _AnswersScreenState();
}

class _AnswersScreenState extends State<AnswersScreen> {
  final TextEditingController answerController = TextEditingController();
  String? userName;
  getUserData() async {
    var uId = auth.currentUser!.uid;
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    DocumentSnapshot<Object?> userDocSnapshot =
        await usersCollection.doc(uId).get();
    userName = userDocSnapshot.get('name');
    print(userName);
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryPrimaryColor,
      appBar: appBar('Community Answers', false, () => null),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('community')
                  .doc(widget.questionDocumentId)
                  .collection('answers')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No answers available for the question.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var answer = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                            color: secondaryPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  answer['answer'],
                                  style: montserrat12,
                                ),
                                Text(
                                  'answered by: ${answer['answeredBy']}',
                                  style: montserrat12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          auth.currentUser != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: customTextField(
                      auth.currentUser!.uid == widget.id
                          ? 'Reply..'
                          : 'Help Him ...',
                      answerController, () {
                    if (answerController.text.isEmpty) {
                      showSnackbar(
                          context, Colors.red, 'Text field cannot be empty');
                    } else {
                      databaseFunctions.addAnswerToQuestion(
                          widget.questionDocumentId,
                          userName!,
                          answerController.text.toString());
                    }
                  }, true),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
