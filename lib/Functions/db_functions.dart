// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:unitedbiker/Packages/packages.dart';

class DatabaseFunctions {
  loginUser(emailController, passController, BuildContext context,
      bool fromProductPage) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController, password: passController);
      fromProductPage
          ? screenFunctions.popScreen(context)
          : screenFunctions.nextScreen(context, const Navigation());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar(context, Colors.red, 'No user found');
      } else if (e.code == 'wrong-password') {
        showSnackbar(context, Colors.red, 'check your password');
      }
    }
  }

  Future<void> createUser(String email, String password, String name,
      BuildContext context, bool fromProductPage) async {
    try {
      // Create user in Firebase Authentication
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Store additional information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'email': email,
        'password': password,
        'name': name,
      });
      fromProductPage
          ? screenFunctions.popScreen(context)
          : screenFunctions.nextScreen(context, const Navigation());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbar(context, Colors.red, 'password is too weak');
      } else if (e.code == 'email-already-in-use') {
        showSnackbar(context, Colors.red, 'account already exist');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getBikesData(String category) async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(category);

      // Get the documents from the collection
      QuerySnapshot snapshot = await collectionRef.get();

      // Extract data from the documents
      List<Map<String, dynamic>> bikesData = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> bike = {
          'price': doc['price'],
          'description': doc['description'],
          'modelname': doc['modelname'],
          'companyname': doc['companyname'],
          'usedtime': doc['usedtime'],
          'contact': doc['contact'],
        };
        bikesData.add(bike);
      }

      return bikesData;
    } catch (e) {
      print('Error getting popular bikes: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchBikePictures(String category) async {
    try {
      QuerySnapshot newBikesSnapshot =
          await FirebaseFirestore.instance.collection(category).get();

      List<Map<String, dynamic>> result = [];

      for (QueryDocumentSnapshot bikeDocument in newBikesSnapshot.docs) {
        QuerySnapshot nikePicturesSnapshot =
            await bikeDocument.reference.collection('bikepictures').get();

        for (QueryDocumentSnapshot nikePictureDocument
            in nikePicturesSnapshot.docs) {
          Map<String, dynamic> nikePictureData =
              nikePictureDocument.data() as Map<String, dynamic>;
          result.add(nikePictureData);
        }
      }

      return result;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getProductData(String category) async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(category);

      // Get the documents from the collection
      QuerySnapshot snapshot = await collectionRef.get();

      // Extract data from the documents
      List<Map<String, dynamic>> productData = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> product = {
          'price': doc['price'],
          'description': doc['description'],
          'company': doc['company'],
          'contact': doc['contact'],
          'imageLink': doc['imageLink'],
        };
        productData.add(product);
      }

      return productData;
    } catch (e) {
      print('Error getting popular bikes: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductPictures(
      String category) async {
    try {
      QuerySnapshot newBikesSnapshot =
          await FirebaseFirestore.instance.collection(category).get();

      List<Map<String, dynamic>> result = [];

      for (QueryDocumentSnapshot bikeDocument in newBikesSnapshot.docs) {
        QuerySnapshot nikePicturesSnapshot =
            await bikeDocument.reference.collection('pictures').get();

        for (QueryDocumentSnapshot nikePictureDocument
            in nikePicturesSnapshot.docs) {
          Map<String, dynamic> nikePictureData =
              nikePictureDocument.data() as Map<String, dynamic>;
          result.add(nikePictureData);
        }
      }

      return result;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<void> addOrder(String productName, int quantity, String userId,
      BuildContext context) async {
    final CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    // Generate a random orderId
    String orderId = generateRandomOrderId();

    // Get the current server time
    DateTime orderTime = DateTime.now();

    try {
      // Add data to the "orders" collection
      await ordersCollection.add({
        'orderId': orderId,
        'productName': productName,
        'quantity': quantity,
        'orderTime': orderTime,
        'userId': userId,
      });
      showSnackbar(context, Colors.green,
          'Order placed successfully. Your order number is $orderId');

      print('Order added successfully!');
    } catch (e) {
      print('Error adding order: $e');
    }
  }

  String generateRandomOrderId() {
    // Generate a random string of length 6 consisting of alphabets and digits
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const length = 6;
    String randomString = '';
    final random = Random();

    for (int i = 0; i < length; i++) {
      randomString += chars[random.nextInt(chars.length)];
    }

    return randomString;
  }

  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    // Get the current logged-in user ID

    // Fetch orders where userId matches the current logged-in user ID
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .get();

    // Convert the documents to a list of maps
    List<Map<String, dynamic>> userOrders = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();

    return userOrders;
  }

  // community functions
  Future<void> postQuestion(String question, String askedBy, String userId,
      BuildContext context) async {
    final CollectionReference communityCollection =
        FirebaseFirestore.instance.collection('community');

    try {
      // Add data to the "community" collection and get the DocumentReference
      DocumentReference questionDocRef = await communityCollection.add({
        'question': question,
        'askedBy': askedBy,
        'userId': userId,
        'questionId': '', // Placeholder value, will be updated below
      });

      // Update the 'questionId' field with the actual document ID
      await questionDocRef.update({'questionId': questionDocRef.id});

      showSnackbar(
          context, Colors.green, 'Your question is posted in community');
      print('Question posted successfully!');
      questionController.clear();
    } catch (e) {
      print('Error posting question: $e');
      showSnackbar(context, Colors.red, 'Error posting question');
    }
  }

  // get all community questions

  Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final CollectionReference communityCollection =
        FirebaseFirestore.instance.collection('community');
    try {
      // Fetch all documents from the "community" collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await communityCollection.get()
              as QuerySnapshot<Map<String, dynamic>>;

      // Convert the documents to a list of maps
      List<Map<String, dynamic>> questions = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
          .toList();

      return questions;
    } catch (e) {
      print('Error getting questions: $e');
      return [];
    }
  }

  // enter answer
  Future<void> addAnswerToQuestion(
      String questionDocumentId, String answeredBy, String answer) async {
    final CollectionReference communityCollection =
        FirebaseFirestore.instance.collection('community');
    final DocumentReference questionDocRef =
        communityCollection.doc(questionDocumentId);

    try {
      await questionDocRef.collection('answers').add({
        'answeredBy': answeredBy,
        'answer': answer,
      });
    } catch (e) {
      print('Error adding answer to the question: $e');
    }
  }

  // bike listing
  Future<void> uploadBikeData(
      List<File> selectedImages,
      String companyName,
      String contact,
      String description,
      String modelName,
      String uploadedBy,
      String usedTime,
      String price) async {
    try {
      // Upload images to Firebase Storage and get their download URLs
      List<String> imageUrls = await uploadImages(selectedImages);

      // Save bike data to Firestore
      await FirebaseFirestore.instance.collection('usedbikes').add({
        'price': price,
        'companyname': companyName,
        'contact': contact,
        'description': description,
        'modelname': modelName,
        'uploadedby': uploadedBy,
        'usedtime': usedTime,
        'bikepictures': imageUrls, // Store image download URLs in Firestore
      });
    } catch (e) {
      print('Error uploading bike data: $e');
      // Handle error as needed
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];

    try {
      for (File image in images) {
        // Create a unique file name for each image
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        // Upload image to Firebase Storage
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('bike_images/$fileName')
            .putFile(image);

        // Get download URL of the uploaded image
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Add download URL to the list
        imageUrls.add(downloadUrl);
      }

      return imageUrls;
    } catch (e) {
      print('Error uploading images: $e');
      // Handle error as needed
      return [];
    }
  }
}
