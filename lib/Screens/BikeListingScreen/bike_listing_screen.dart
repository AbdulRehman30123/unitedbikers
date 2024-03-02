import 'package:unitedbiker/Packages/packages.dart';

class BikeListingScreen extends StatefulWidget {
  const BikeListingScreen({super.key});

  @override
  State<BikeListingScreen> createState() => _BikeListingScreenState();
}

class _BikeListingScreenState extends State<BikeListingScreen> {
  List<File> selectedImages = [];

  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryPrimaryColor,
      appBar: appBar('Bike Listing', false, () => null),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  // Open gallery to pick an image
                  final pickedFile =
                      await _imagePicker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      selectedImages.add(File(pickedFile.path));
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  ),
                  height: 200,
                  width: double.infinity,
                  child: selectedImages.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add),
                            Text(
                              'Add Bike Pictures',
                              style: montserrat12,
                            ),
                          ],
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(
                                    selectedImages[index],
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImages.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ),
              singleLineField(companyNameController, 'Company Name'),
              singleLineField(modelNumberController, 'Model Number'),
              singleLineField(bikePriceController, 'Bike Price'),
              singleLineField(bikeUsedTimeController, 'Used Time'),
              singleLineField(bikeOwnerNumber, 'Contact Number'),
              multiLineField(bikeDescriptionController, 'Description'),
              GestureDetector(
                onTap: () {
                  if (selectedImages.isEmpty ||
                      modelNumberController.text.isEmpty ||
                      companyNameController.text.isEmpty ||
                      bikeUsedTimeController.text.isEmpty ||
                      bikeOwnerNumber.text.isEmpty ||
                      bikeDescriptionController.text.isEmpty ||
                      bikePriceController.text.isEmpty) {
                    showSnackbar(
                        context, Colors.red, 'Please fil all the fields');
                  } else {
                    databaseFunctions
                        .uploadBikeData(
                      selectedImages,
                      companyNameController.text.toString(),
                      bikeOwnerNumber.text.toString(),
                      bikeDescriptionController.text.toString(),
                      modelNumberController.text.toString(),
                      auth.currentUser!.uid,
                      bikeUsedTimeController.text.toString(),
                      bikePriceController.text.toString(),
                    )
                        .then((value) {
                      showSnackbar(context, Colors.green, 'Uploaded..');
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appBarColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Bike',
                      style: montserratWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  singleLineField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: montserratWhite,
        controller: controller,
        decoration: InputDecoration(
            fillColor: appBarColor,
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

  multiLineField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: montserratWhite,
        controller: controller,
        maxLines: null, // Set maxLines to null for a multi-line text field
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          fillColor: appBarColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: montserratWhite,
        ),
      ),
    );
  }
}
