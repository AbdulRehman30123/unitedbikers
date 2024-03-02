import 'package:unitedbiker/Packages/packages.dart';
import 'package:unitedbiker/Screens/BikeSection/BikeDetailScreen/bike_detail_screen.dart';

class BikeSectionScreen extends StatefulWidget {
  BikeSectionScreen({super.key, required this.bikeCategory});
  String bikeCategory;

  @override
  State<BikeSectionScreen> createState() => _BikeSectionScreenState();
}

class _BikeSectionScreenState extends State<BikeSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          widget.bikeCategory == 'usedbikes'
              ? 'Used Bikes'
              : widget.bikeCategory == 'popularbikes'
                  ? 'Popular Bikes'
                  : 'New Bikes',
          false,
          () {}),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.bikeCategory)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No bikes available'));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  2, // You can adjust the number of columns as needed
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Existing code for fetching bike data
              var bikeData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String companyName = bikeData['companyname'] ?? '';
              String contact = bikeData['contact'] ?? '';
              String productDescription = bikeData['description'] ?? '';
              String modelName = bikeData['modelname'] ?? '';
              String uploadedBy = bikeData['uploadedby'] ?? '';
              String yearsUsed = bikeData['usedtime'] ?? '';
              String productPrice = bikeData['price'] ?? '';
              List<String> imageUrls =
                  List<String>.from(bikeData['bikepictures'] ?? []);
              return GestureDetector(
                onTap: () {
                  screenFunctions.nextScreen(
                    context,
                    BikeDetailScreen(
                      modelName: modelName,
                      productDescription: productDescription,
                      productPrice: productPrice,
                      usedBike: true,
                      contact: contact,
                      yearsUsed: yearsUsed,
                      bikesPicture: imageUrls,
                    ),
                  );
                },
                child: GridTile(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 2, right: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              imageUrls.isNotEmpty ? imageUrls[0] : ''),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondaryPrimaryColor,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                modelName,
                                style: montserratBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // You can add more content or functionality if needed
                ),
              );
            },
          );
        },
      ),
    );
  }
}
